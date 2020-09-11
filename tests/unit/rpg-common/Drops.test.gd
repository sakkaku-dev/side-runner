extends WAT.Test

var drops: Drops

func pre():
	drops = Drops.new()

func _mock_item(chance, item) -> Node:
	var item_mock = Mockito.mock(ItemDrop)
	item_mock.method("get_drop_chance").stub(chance)
	item_mock.method("get_item").stub(item)
	return item_mock.double()

func test_drop_chance():
	drops.drop_chance = 0.5
	
	var dropped = 0
	for i in range(1000):
		if drops.is_dropping_item():
			dropped += 1

	# Inside 10% interval
	asserts.is_greater_than(dropped, 1000 * 0.4)
	asserts.is_less_than(dropped, 1000 * 0.6)

func test_get_random_drops_based_on_percentage():
	drops.add_child(_mock_item(50, "50%"))
	drops.add_child(_mock_item(90, "90%"))
	drops.add_child(_mock_item(10, "10%"))
	
	var counts = {}
	for i in range(1000):
		var item = drops.get_random_drop()
		if counts.has(item):
			counts[item] +=1
		else:
			counts[item] = 1
			
	var c90 = counts.get("90%", 0)
	var c50 = counts.get("50%", 0)
	var c10 = counts.get("10%", 0)

	asserts.is_greater_than(c90, c50)
	asserts.is_greater_than(c50, c10)

func test_random_drop_with_empty_items():
	asserts.is_null(drops.get_random_drop())

func test_add_drop_to_node():
	drops.add_child(_mock_item(100, Mockito.pack_scene(Node.new())))
	
	var parent = Node.new()
	drops.drop_chance = 1
	
	asserts.is_not_null(drops.add_drop_to(parent))
	asserts.is_not_null(parent.get_child(0))
	
func test_not_add_drop_if_not_dropping():
	drops.add_child(_mock_item(100, Mockito.pack_scene(Node.new())))
	
	var parent = Node.new()
	drops.drop_chance = 0
	drops.add_drop_to(parent)
	
	asserts.is_null(parent.get_child(0))

func test_not_add_drop_if_no_item_dropping():
	drops.add_child(_mock_item(0, Mockito.pack_scene(Node.new())))
	
	var parent = Node.new()
	drops.drop_chance = 1
	drops.add_drop_to(parent)
	
	asserts.is_null(parent.get_child(0))
