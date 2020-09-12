extends Area2D

signal damage_inflicted(dir)
signal invincible_start
signal invincible_end

class_name HurtArea

export var invincibility_time = 2
export var health_path: NodePath

onready var collision := $CollisionShape2D
onready var invincibility_timer := $InvincibilityTimer

var health: Health

func _ready():
	invincibility_timer.wait_time = invincibility_time
	if not health_path.is_empty():
		health = get_node(health_path)

func damage(dmg: int, hit_direction: Vector2 = Vector2.ZERO) -> void:
	if health != null:
		health.health -= dmg
		
	# Not possible to emit damage?
	emit_signal("damage_inflicted", hit_direction)

	collision.set_deferred("disabled", true)
	emit_signal("invincible_start")
	invincibility_timer.start()

func _on_InvincibilityTimer_timeout():
	collision.disabled = false
	collision.update()
	emit_signal("invincible_end")
