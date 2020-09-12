extends KinematicBody2D

onready var state := $MoveState
onready var cliff_cast := $CliffCast
onready var drops := $Drops
onready var bounce_sound := $Bounce

var dir = Vector2.LEFT

func _physics_process(_delta: float) -> void:
	if not cliff_cast.is_colliding():
		dir *= -1
		scale.x *= -1

	state.direction = dir

func die_hit(_hit_dir: Vector2) -> void:
	die()

func die_bounce() -> void:
	bounce_sound.play(0)
	bounce_sound.connect("finished", self, "die")
	hide()

func die() -> void:
	var drop = drops.add_drop_to(get_parent())
	if drop != null:
		drop.global_position = global_position
	queue_free()
