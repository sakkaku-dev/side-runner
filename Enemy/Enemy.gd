extends KinematicBody2D

onready var state := $MoveState
onready var cliff_cast := $CliffCast
onready var drops := $Drops

var dir = Vector2.LEFT

func _physics_process(delta: float) -> void:
	if not cliff_cast.is_colliding():
		dir *= -1
		scale.x *= -1

	state.direction = dir

func die() -> void:
	var drop = drops.add_drop_to(get_parent())
	if drop != null:
		drop.global_position = global_position
	queue_free()
