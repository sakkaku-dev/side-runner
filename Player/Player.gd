extends KinematicBody2D

signal died

export var jump = 700

onready var sprite := $Sprite
onready var state := $MoveState
onready var animation := $AnimationPlayer

func _physics_process(delta: float) -> void:
	state.direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor():
		if state.velocity.length() <= 0.01:
			animation.play("Idle")
		else:
			animation.play("Run")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		state.gravity_multiplier = 0.3
		state.velocity.y -= jump
		animation.play("Jump")
	
	# Restore gravity if jump release or starting to fall down
	if Input.is_action_just_released("jump") or state.velocity.y >= 0:
		state.gravity_multiplier = 1

	if state.velocity.x != 0:
		sprite.flip_h = state.velocity.x < 0

func die() -> void:
	queue_free()
	emit_signal("died")
