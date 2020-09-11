extends Area2D

class_name Pickable

export var id: String
export var item: PackedScene
export var pick_up_timer = 10

onready var timer = $PickUpTimer

func _ready():
	timer.wait_time = pick_up_timer
	timer.start()

func _on_PickUpTimer_timeout():
	queue_free()
