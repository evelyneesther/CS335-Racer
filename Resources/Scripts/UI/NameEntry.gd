extends TextEdit


var LIMIT=10
var current_text = ''

func _on_TextEdit_text_changed():
	var new_text : String = TextEdit.text
	if new_text.length() > LIMIT:
		TextEdit.text = current_text
	current_text = TextEdit.text 
