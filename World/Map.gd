extends TileMap

const TILE_ID = 0

export var max_distance = 4
export var max_platform_length = 20
export var max_generate_distance = 50

export var enemy_scene: PackedScene

onready var visibility_notifier = $VisibilityNotifier2D

var last_block_pos = Vector2.ZERO

func _ready():
	randomize()
	_update_last_block_position()
	_update_map()
	
func _update_last_block_position() -> void:
	var last_x = 0
	var last_y = 0
	
	for cell in get_used_cells():
		last_x = max(last_x, cell.x)
		last_y = max(last_y, cell.y)
		
	last_block_pos = Vector2(last_x, last_y)

func _update_map() -> void:
	var last_block = last_block_pos
	_update_visibility_notifier_position(last_block)
	
	while last_block.x <= last_block_pos.x + max_generate_distance:
		var distance = max(2, (randi() % max_distance) + 1)
		var length = (randi() % max_platform_length) + 1
		
		var new_pos = last_block + Vector2(distance, 0)
		last_block = _create_platform(new_pos, length)
		
		if length >= 6:
			var enemy = enemy_scene.instance()
			add_child(enemy)
			enemy.global_position = map_to_world(Vector2(last_block.x - 1, last_block.y - 1))
	
	last_block_pos = last_block
	
func _update_visibility_notifier_position(cell_pos: Vector2) -> void:
	visibility_notifier.global_position = map_to_world(cell_pos)

func _create_platform(pos: Vector2, length: int) -> Vector2:
	for i in range(0, length):
		_create_tile_at(pos)
		pos.x += 1
	return pos

func _create_tile_at(pos: Vector2) -> void:
	set_cellv(pos, TILE_ID)
	update_bitmask_area(pos)

func _on_VisibilityNotifier2D_screen_entered():
	_update_map()
	print("Updated")
