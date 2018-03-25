extends AcceptDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("visibility_changed", self, "on_visibility_changed")

	register_text_enter($VBoxContainer/HBoxContainer2/LineEdit)
	
	pass

func on_visibility_changed():
	$VBoxContainer/HBoxContainer2/LineEdit.grab_focus()

func getName():
	return $VBoxContainer/HBoxContainer2/LineEdit.text
	
func clear():
	$VBoxContainer/HBoxContainer2/LineEdit.clear()
	
func setScore(score):
	$VBoxContainer/ScoreLabel.text = str("Você fez ", score, " pontos!")
