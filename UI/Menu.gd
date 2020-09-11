extends Control

signal start
signal restart

onready var main_options = $MainOptions
onready var controls = $Controls
onready var gameover  = $GameOver

func start() -> void:
	hide()
	emit_signal("start")

func show_controls() -> void:
	main_options.hide()
	controls.show()

func hide_controls() -> void:
	main_options.show()
	controls.hide()

func show_game_over() -> void:
	show()
	main_options.hide()
	gameover.show()

func restart() -> void:
	gameover.hide()
	main_options.show()
	emit_signal("restart")
