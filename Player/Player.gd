extends KinematicBody2D

export var jump = 700

onready var state := $MoveState

func _physics_process(delta: float) -> void:
	state.direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		state.gravity_multiplier = 0.3
		state.velocity.y -= jump
	
	# Restore gravity if jump release or starting to fall down
	if Input.is_action_just_released("jump") or state.velocity.y > 0:
		state.gravity_multiplier = 1
