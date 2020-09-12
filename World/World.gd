extends Node2D

onready var limit := $LeftLimit
onready var camera := $MainCamera
onready var map := $Map
onready var player_health := $Player/Health
onready var player := $Player
onready var bgm := $BGM
onready var player_died_sound := $PlayerDied
onready var start_block := $StartBlock/CollisionShape2D
onready var score_label := $CanvasLayer/HBoxContainer/MarginContainer/Score

var high_score = -1 setget set_high_score

func set_high_score(score: int) -> void:
	if high_score != score:
		high_score = score
		print(high_score)
		score_label.text = "Score: " + str(high_score)

func _process(delta: float) -> void:
	if player == null:
		return

	if player.global_position.x <= 1000:
		self.high_score = 0
	else:
		self.high_score = floor(player.global_position.x / 1000)

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
	self.high_score = 0
	
func restart_game():
	if get_tree().change_scene("res://World/World.tscn"):
		print("Failed to restart game")

func player_died():
	bgm.stop()
	player_died_sound.play()
