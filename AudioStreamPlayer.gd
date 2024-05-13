extends AudioStreamPlayer

var car
var musicPath
var music

# Called when the node enters the scene tree for the first time.
func _ready():
	car = String(CarArt.selected_car()).get_slice(".", 0)
	car = car.get_slice("res://", 1)
	car = car.get_slice("/", 2)
	
	if car.casecmp_to("Red -") == 0:
		musicPath = "res://Music/Base_audio.wav"
	elif car.casecmp_to("Red - SideWing") == 0:
		musicPath = "res://Music/SideWing.wav"
	elif car.casecmp_to("Red - FrontWing") == 0:
		musicPath = "res://Music/FrontWing.wav"
	elif car.casecmp_to("Red - FrontWing SideWing") == 0:
		musicPath = "res://Music/FrontWing SideWing.wav"
	
	music = load(musicPath)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_playing():
		stream = music
		play()
