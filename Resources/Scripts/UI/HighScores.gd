extends Label

func _ready():
	ManagerGame.readScores
func loadScores():
	var scores=ManagerGame.highScores
	var times=scores.keys()
	times.sort()
	var names=[]
	for x in times:
		names.append(scores[x])
	var out=""
	for x in range(0, times.size()):
		if x>7:
			break
		if x>0:
			out=out+'\n'+names[x]+": "+str(times[x])
		else:
			out=names[x]+": "+str(times[x])
	ManagerGame.writeScores(out)
	self.text=out
	pass # Replace with function body.
