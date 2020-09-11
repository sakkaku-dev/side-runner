extends RayCast2D

class_name BounceDetection

signal bounce(factor)

func _is_colliding_with_bounce() -> bool:
	return is_colliding() and get_collision_normal().y < 0

func _bounce_distance() -> Vector2:
	if _is_colliding_with_bounce():
		return get_collision_point() - global_position - Vector2.DOWN
	return Vector2.ZERO

func check_bounce(velocity: Vector2, delta: float) -> void:
	cast_to = velocity * delta
	force_raycast_update()
	if _is_colliding_with_bounce():
		var collider = get_collider()
		var factor = 1
		if collider is BounceArea:
			collider.bounced()
			collider.bounce_factor

		emit_signal("bounce", factor)
