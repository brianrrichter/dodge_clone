extends Node

var currentScene = null
var preferences = null
const SAVE_FILE = "user://savegame.save"
const PREFERENCES_FILE = "user://preferences.save"

func _ready():
	get_tree().set_auto_accept_quit(false)
	
	preferences = getPreferences()
	
	muteSound(!preferences["sound_enabled"])

	
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		preferences["sound_enabled"] = !isSoundMuted()
		savePreferences()
		get_tree().quit()
	if  what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: #android
		preferences["sound_enabled"] = !isSoundMuted()
		savePreferences()


func setScene(scene):
	currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)

#func saveGame():
#	print('saveGame - init')
#	print(OS.get_user_data_dir())
#	var saveGame = File.new()
#	saveGame.open(SAVE_FILE, File.WRITE)
#	saveGame.store_line('["hello", "world", "!"]')
#	saveGame.close()
#	print('saveGame - end')
	
#func loadGame():
#	print('loadGame - init')
#	var saveGame = File.new()
#	if not saveGame.file_exists(SAVE_FILE):
#		return
#
#	saveGame.open(SAVE_FILE, File.READ)
#
#	while not saveGame.eof_reached():
##		print('loadGame - while')
#		print (str("line read: ", saveGame.get_line()))
##	print (saveGame.get_line());
#
#	saveGame.close()
#
#	print('loadGame - end')

func getPreferences():

	var file = File.new()
#	if not file.file_exists(PREFERENCES_FILE):
#		return
	
	file.open(PREFERENCES_FILE, File.READ)
	var fileContent = file.get_as_text()
	file.close()
	
	
	var p = JSON.parse(fileContent).result
	print(str('type: ', typeof(p)))
	if typeof(p) == TYPE_DICTIONARY:
		return p
	else:
		print("unexpected results")
		p = {"sound_enabled": true}
	return p

func savePreferences():
	var file = File.new()
	file.open(PREFERENCES_FILE, File.WRITE)
	file.store_line(to_json(preferences))
	file.close()

func getScore():
	var saveGame = File.new()
#	if not saveGame.file_exists(SAVE_FILE):
#		return
#
	saveGame.open(SAVE_FILE, File.READ)
	
	var fileContent = saveGame.get_as_text()
	
	saveGame.close()
	
#	print('eeeeeeeee')
	var p = JSON.parse(fileContent).result
#	print(str('type: ', typeof(p)))
	if typeof(p) == TYPE_ARRAY:
		return p
#		var d = {"name": "john", "score": 22}
#		p.append(d)
#		print(p[1]["name"]) # prints 'hello'
#		print(p[1]["score"])
	else:
		print("unexpected results")
		p = []
#	print('hhhhhhh')
	return p
	
func isScoreGoodEnough(score):
	var scoreList = getScore()
	if !scoreList.empty() && scoreList.size() >= 10:
		return score > scoreList.back()["score"];
	return true;
	
func addScore(name, score):
	var scores = getScore()
	if scores == null:
		scores = []
	var newScore = {"name": name, "score": score}
	scores.append(newScore)
	
	scores.sort_custom(MyCustomSorter, "sort")
	
	if scores.size() > 10:
		scores.remove(scores.size() -1)
	
#	print(OS.get_user_data_dir())
	var saveGame = File.new()
	saveGame.open(SAVE_FILE, File.WRITE)
	saveGame.store_line(to_json(scores))
	saveGame.close()
	
#	print('addScore')

func muteSound(mute):
#	print(str("buzz count: ",  AudioServer.get_bus_count()))
	for i in AudioServer.get_bus_count():
		AudioServer.set_bus_mute(i, mute)

func isSoundMuted():
	for i in AudioServer.get_bus_count():
		return AudioServer.is_bus_mute(i)
	return false;


# Auxiliary classes

class MyCustomSorter:
	static func sort(a, b):
		if a["score"] > b["score"]:
			return true
		return false
	
	
	