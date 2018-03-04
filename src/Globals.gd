extends Node

var currentScene = null

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)

func setScene(scene):
	currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)

func saveGame():
	print('saveGame - init')
	print(OS.get_user_data_dir())
	var saveGame = File.new()
	saveGame.open("user://savegame.save", File.WRITE)
	saveGame.store_line('["hello", "world", "!"]')
	saveGame.close()
	print('saveGame - end')
	
func loadGame():
	print('loadGame - init')
	var saveGame = File.new()
	if not saveGame.file_exists("user://savegame.save"):
		return
	
	saveGame.open("user://savegame.save", File.READ)
	
	while not saveGame.eof_reached():
#		print('loadGame - while')
		print (str("line read: ", saveGame.get_line()))
#	print (saveGame.get_line());
		
	saveGame.close()
	
	print('loadGame - end')

func getScore():
	var saveGame = File.new()
	if not saveGame.file_exists("user://savegame.save"):
		return
	
	saveGame.open("user://savegame.save", File.READ)
	
	var fileContent = saveGame.get_as_text()
	
	print('eeeeeeeee')
	var p = JSON.parse(fileContent).result
	print(str('type: ', typeof(p)))
	if typeof(p) == TYPE_ARRAY:
		return p
#		var d = {"name": "john", "score": 22}
#		p.append(d)
#		print(p[1]["name"]) # prints 'hello'
#		print(p[1]["score"])
	else:
		print("unexpected results")
		p = []
	print('hhhhhhh')
	return p
	
	
	
func addScore(name, score):
	var scores = getScore()
	if scores == null:
		scores = []
	var newScore = {"name": name, "score": score}
	scores.append(newScore)
	
	if scores.size() > 10:
		scores.remove(0)
	
#	print(OS.get_user_data_dir())
	var saveGame = File.new()
	saveGame.open("user://savegame.save", File.WRITE)
	saveGame.store_line(to_json(scores))
	saveGame.close()
	
	print('addScore')
