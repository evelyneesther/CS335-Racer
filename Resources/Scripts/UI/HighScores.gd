extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var scores=ManagerGame.highScores
	print(scores)
	var times=scores.keys()
	times.sort()
	var names=[]
	for x in times:
		names.append(scores[x])
	var out=""
	for x in range(0, times.size()):
		if x>0:
			out=out+'\n'+names[x]+": "+str(times[x])
		else:
			out=names[x]+": "+str(times[x])
	self.text=out
	ManagerGame.writeScores(out)
	pass # Replace with function body.

