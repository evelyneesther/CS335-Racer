extends Button


func _physics_process(delta: float) -> void:
	if is_pressed():
		var name=%NameField.text
		name=name.to_upper()
		if name.length()!=3:
			%Alert.visible=true
		else:
			ManagerGame.newScore(ManagerGame.fastestLap,name)
			%PositionRank.loadScores()
			%HighScores.visible=true
			%NameEnter.visible=false
