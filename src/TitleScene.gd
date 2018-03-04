extends TextureRect

func _ready():
	set_process(true)

func _process(delta):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		get_node("/root/Globals").setScene("res://scenes/Main.tscn")
#		get_node("/root/Globals").saveGame()
#		get_node("/root/Globals").loadGame()
#
#		print('eeeeeeeee')
#		var p = JSON.parse('[{"name": "player", "score":0}]').result
#		print(str('type: ', typeof(p)))
#		if typeof(p) == TYPE_ARRAY:
#			var d = {"name": "john", "score": 22}
#			p.append(d)
#			print(p[1]["name"]) # prints 'hello'
#			print(p[1]["score"])
#		else:
#			print("unexpected results")
#		print('hhhhhhh')