extends KinematicBody2D

signal died

export var jump = 700
export var bounce_force = 1000

onready var state := $MoveState
onready var animation := $AnimationPlayer
onready var bounce_detection := $BounceDetection
onready var body := $Body
onready var hand := $Body/HandPosition
onready var blink_player := $BlinkPlayer

var equipped_item = ""

func _physics_process(delta: float) -> void:
	state.direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor():
		if state.velocity.length() <= 0.01:
			animation.play("Idle")
		else:
			animation.play("Run")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		state.gravity_multiplier = 0.3
		state.velocity.y = -jump
		animation.play("Jump")
	
	# Restore gravity if jump release or starting to fall down
	if Input.is_action_just_released("jump") or state.velocity.y >= 0:
		state.gravity_multiplier = 1

	if state.velocity.x != 0:
		body.scale.x = -1 if state.velocity.x < 0 else 1
		
	if state.velocity.y > 0:
		bounce_detection.check_bounce(state.velocity, delta)
		
	if Input.is_action_just_pressed("attack") and has_weapon():
		get_weapon().attack()
		
func has_weapon() -> bool:
	return hand.get_child_count() > 0
		
func get_weapon() -> Weapon:
	return hand.get_child(0) as Weapon

func die() -> void:
	queue_free()
	emit_signal("died")

func bounce(bounce_factor: int) -> void:
	state.velocity.y = -bounce_force * bounce_factor

func equip_item(id: String, item: PackedScene) -> void:
	if equipped_item == id:
		return
	
	equipped_item = id
	for i in range(hand.get_child_count()):
		hand.get_child(i).delete_weapon()
		
	hand.call_deferred("add_child", item.instance())

func start_blink() -> void:
	blink_player.play("Blink")

func stop_blink() -> void:
	blink_player.stop()

func hit_knockback(hit_dir: Vector2) -> void:
	state.velocity += hit_dir
