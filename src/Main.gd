extends Node

export (PackedScene) var Mob
export (PackedScene) var BlinkingDot
var score
const _Mob = preload("Mob.gd")

var delayedMob
var blinkingDot

func _ready():
	randomize()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func game_over():
	if (delayedMob != null):
		delayedMob.queue_free()
		delayedMob = null
	if (blinkingDot != null):
		blinkingDot.queue_free()
		blinkingDot = null
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	if get_node("/root/Globals").isScoreGoodEnough(score):
		$HUD.showNameDialog(score)
	else:
		$HUD.show_buttons()
	
	

func new_game():
	#remover inimigos
	for n in get_children():
#		print(n.get_class())
		if (n is _Mob):
			n.queue_free()
	
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
#	print("new_game()")

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score +=1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	if  (delayedMob != null):
		add_child(delayedMob)
	
	# choosea random location on the Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	# create a Mob instance and add it to the scene
	var mob = Mob.instance()
#	add_child(mob)
	delayedMob = mob
	# set the mob's direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	# set the mob's position to the random location
	mob.position = $MobPath/MobSpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	# choose the velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED),  0).rotated(direction))

	if blinkingDot == null:
		blinkingDot = BlinkingDot.instance()
		add_child(blinkingDot)
		
	blinkingDot.position = mob.position


func _on_HUD_name_informed():
	$HUD.show_buttons()
