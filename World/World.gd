extends Node2D

onready var limit := $LeftLimit
onready var camera := $MainCamera
onready var map := $Map
onready var player_health := $Player/Health
onready var player := $Player
onready var bgm := $AudioStreamPlayer

func set_left_limit(pos_x: int) -> void:
	camera.limit_left = pos_x
	limit.global_position.x = pos_x

func player_outside_map():
	player_health.health -= 1
	player.global_position = map.get_start_cell_position()
