extends AcceptDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func getName():
	return $VBoxContainer/HBoxContainer2/LineEdit.text
	
func clear():
	$VBoxContainer/HBoxContainer2/LineEdit.clear()
	
func setScore(score):
	$VBoxContainer/ScoreLabel.text = str("Você fez ", score, " pontos!")
