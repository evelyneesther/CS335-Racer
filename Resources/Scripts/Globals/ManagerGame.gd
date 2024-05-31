extends Node


signal pop_to_ui(instance)
signal race_finished

var currMap=""
var laps_max = 1

var startTime
var endTime
var fastestLap=99999999999

var highScores
var scoreFile

var global_level_ref = null


func readScores():

	if currMap=="res://Resources/Scenes/overhead.tscn":
		scoreFile="res://Users/MeadowHighScores.txt"
	else:
		scoreFile="res://Users/ParkwayHighScores.txt"
	var file = FileAccess.open(scoreFile, FileAccess.READ)
	var content = file.get_as_text()
	print(content)
	var rows=content.split('\n')
	var scores={}
	for x in range(0,rows.size()):
		var temp=rows[x].split(": ")
		if temp.size()==1:
			continue
		scores[float(temp[1])]=temp[0]
	print("Manager Scores")
	print(scores)
	highScores=scores
	
func newScore(time, player):
	var scores=highScores
	scores[time]=player
	highScores=scores
	return(highScores)

func writeScores(txt):
	var file = FileAccess.open(scoreFile, FileAccess.WRITE)
	file.store_string(txt)
	file.close()




