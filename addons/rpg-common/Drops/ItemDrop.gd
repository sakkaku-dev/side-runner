extends Node

class_name ItemDrop

export var drop_chance = 0
export var item: PackedScene

func get_drop_chance() -> int:
	return drop_chance
	
func get_item() -> PackedScene:
	return item
