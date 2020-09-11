extends KinematicBody2D

onready var state := $MoveState
onready var cliff_cast := $CliffCast

var dir = Vector2.LEFT

func _physics_process(delta: float) -> void:
	if not cliff_cast.is_colliding():
		dir *= -1
		scale.x *= -1

	state.direction = dir
