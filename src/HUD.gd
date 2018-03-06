extends CanvasLayer

signal start_game
signal name_informed

var _score

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
#	$StartButton.show()
#	$ScoreButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
func show_buttons():
	$StartButton.show()
	$ScoreButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$ScoreButton.hide()
	emit_signal("start_game")
#	print("_on_StartButton_pressed")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_ScoreButton_pressed():
	get_node("/root/Globals").setScene("res://scenes/ScoreScene.tscn")



func _on_TestButton_pressed():
	$ScoreDialog.popup()

func showNameDialog(score):
	_score = score
	$ScoreDialog.setScore(score)
	$ScoreDialog.popup()


func _on_ScoreDialog_confirmed():
	print(str("nome: ", $ScoreDialog.getName()))
	get_node("/root/Globals").addScore($ScoreDialog.getName(), _score)
	emit_signal("name_informed")


func _on_SoundCheckButton_toggled(isOn):
	get_node("/root/Globals").muteSound(!isOn)
