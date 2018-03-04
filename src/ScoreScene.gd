extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var scoreList = get_node("/root/Globals").getScore()
#	var d = {"name": "john", "score": 22}
#	p.append(d)

	var text = ""
	for s in scoreList:
		text += str("\n", s["name"], "...........", s["score"])
#		print(s["name"]) # prints 'hello'
#		print(s["score"])

	$ScoreLabel.text = text

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_backButton_pressed():
	get_node("/root/Globals").setScene("res://scenes/Main.tscn")
