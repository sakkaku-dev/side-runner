extends Area2D

signal pick_up(id, item)

class_name PickUpArea

func _on_PickUpArea_area_entered(area: Area2D):
	if not area is Pickable:
		return
	
	emit_signal("pick_up", area.id, area.item)
	area.queue_free()
