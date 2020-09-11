extends Node2D

onready var limit := $LeftLimit
onready var camera := $MainCamera
onready var map := $Map
onready var player_health := $Player/Health
onready var player := $Player
onready var bgm := $BGM
onready var player_died_sound := $PlayerDied
onready var start_block := $StartBlock/CollisionShape2D

func set_left_limit(pos_x: int) -> void:
	camera.limit_left = pos_x
	limit.global_position.x = pos_x

func player_outside_map():
	player_health.health -= 1
	player.global_position = map.get_start_cell_position()

func start_game():
	camera.limit_right = 10000000
	start_block.disabled = true
	bgm.play()
	
func restart_game():
	get_tree().change_scene("res://World/World.tscn")

func player_died():
	bgm.stop()
	player_died_sound.play()
