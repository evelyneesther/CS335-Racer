extends AudioStreamPlayer

var music

var currTime=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currTime+=delta
	if not is_playing():
		setPlaying()

func setPlaying():
	music = load("res://Resources/Music/Fall.mp3")
	stop()
	stream = music
	play(0)
