extends Node

class_name Drops

export var drop_chance = 1.0

func _get_drops() -> Array:
	return get_children()

func add_drop_to(node: Node) -> Node:
	if is_dropping_item():
		var drop = get_random_drop()
		if drop != null:
			var drop_node = drop.instance()
			node.add_child(drop_node)
			return drop_node
	return null

func is_dropping_item() -> bool:
	return randf() <= drop_chance

func get_random_drop() -> PackedScene:
	var total = 0
	for drop in _get_drops():
		total += drop.get_drop_chance()
		
	if total != 0:
		var random_value = (randi() % total) + 1
		var value = 0
		for drop in _get_drops():
			value += drop.get_drop_chance()
			if random_value <= value:
				return drop.get_item()

	return null
