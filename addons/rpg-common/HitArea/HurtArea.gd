extends Area2D

signal damage_inflicted
signal invincible_start
signal invincible_end

class_name HurtArea

export var invincibility_time = 2

export var health_path: NodePath
onready var health: Health = get_node(health_path)

onready var collision := $CollisionShape2D
onready var invincibility_timer := $InvincibilityTimer

func _ready():
	invincibility_timer.wait_time = invincibility_time

func damage(dmg: int, collision_normal: Vector2 = Vector2.ZERO) -> void:
	if health != null:
		health.health -= dmg
		
	# Not possible to emit damage?
	emit_signal("damage_inflicted")

	collision.set_deferred("disabled", true)
	emit_signal("invincible_start")
	invincibility_timer.start()

func _on_InvincibilityTimer_timeout():
	collision.disabled = false
	collision.update()
	emit_signal("invincible_end")
	print("Enable")
