extends TileMap

# Emit global x axis of new first block after shrinked
signal shrinked(global_first_block_x)

const TILE_ID = 0
const GROUND_HEIGHT = 3

export var max_distance = 4
export var max_platform_length = 20
export var max_generate_distance = 50

export var enemy_scene: PackedScene

export var player_path: NodePath
onready var player = get_node(player_path)

onready var expand_notifier = $ExpandNotifier
onready var shrink_notifier = $ShrinkNotifier
onready var enemy_container = $EnemyContainer

var last_block_pos = Vector2.ZERO

func _ready():
	randomize()
	_update_last_block_position()
	update_map()
	
func _update_last_block_position() -> void:
	var last_x = 0
	var last_y = 0
	
	for cell in get_used_cells():
		last_x = max(last_x, cell.x)
		last_y = max(last_y, cell.y)
		
	last_block_pos = Vector2(last_x, last_y)
	
func get_start_cell_position() -> Vector2:
	var first_x = -1
	for cell in get_used_cells():
		if first_x == -1:
			first_x = cell.x
		else:
			first_x = min(first_x, cell.x)
	
	first_x = max(first_x, 5)
	return map_to_world(Vector2(first_x + 1, 8))

func update_map() -> void:
	var last_block = last_block_pos
	_update_expand_notifier_position(last_block)
	
	while last_block.x <= last_block_pos.x + max_generate_distance:
		var distance = max(3, (randi() % max_distance) + 1)
		var length = (randi() % max_platform_length) + 1
		
		var new_pos = last_block + Vector2(distance, 0)
		last_block = _create_platform(new_pos, length)
		
		if length >= 6:
			var enemy = enemy_scene.instance()
			enemy_container.add_child(enemy)
			enemy.global_position = map_to_world(Vector2(last_block.x - 1, last_block.y - 1 - GROUND_HEIGHT))
	
	last_block_pos = last_block
	
func _update_expand_notifier_position(cell_pos: Vector2) -> void:
	expand_notifier.global_position = map_to_world(cell_pos)

func _create_platform(pos: Vector2, length: int) -> Vector2:
	for _i in range(0, length):
		for _j in range(GROUND_HEIGHT):
			_create_tile_at(pos)
			pos.y -= 1
		pos.x += 1
		pos.y += GROUND_HEIGHT
	return pos

func _create_tile_at(pos: Vector2) -> void:
	set_cellv(pos, TILE_ID)
	update_bitmask_area(pos)

func shrink_map() -> void:
	var start_pos = shrink_notifier.global_position
	
	# Dont shrink if exited in front of the player
	if player == null or start_pos.x > player.global_position.x:
		return
	
	for enemy in enemy_container.get_children():
		if enemy.global_position.x < start_pos.x:
			enemy.queue_free()
	
	var local_start_pos = world_to_map(start_pos)
	var new_first_pos = local_start_pos.x
	for cell in get_used_cells():
		if cell.x < local_start_pos.x:
			set_cellv(cell, -1)
		else:
			new_first_pos = min(new_first_pos, cell.x)
			
	shrink_notifier.global_position = expand_notifier.global_position
	var new_first_global = map_to_world(Vector2(new_first_pos, 0))
	emit_signal("shrinked", new_first_global.x)
