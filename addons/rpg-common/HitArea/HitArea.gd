extends Area2D

class_name HitArea

export var damage = 1


func _on_HitArea_area_entered(area):
	if not area is HurtArea:
		return
	
	area.damage(damage)
