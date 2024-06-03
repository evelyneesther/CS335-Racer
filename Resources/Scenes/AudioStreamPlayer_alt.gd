extends AudioStreamPlayer

var currTime = 0
var endTime = 11
var changed = false

func _process(delta):
	currTime += delta
	if (abs(currTime - endTime) < 0.1 or currTime - endTime > 1) and not changed:
		setTrack()

func setTrack():
	stop()
	stream = load("res://Resources/Music/Fall.mp3")
	changed = true
	play()

func _on_finished():
	play()
