extends Area2D

class_name HitArea

export var damage = 1
export var knockback = 0


func _on_HitArea_area_entered(area: Area2D):
	var hit_dir = global_position.direction_to(area.global_position).normalized()
	area.damage(damage, hit_dir * knockback)
