extends WAT.Test

var health: Health

func pre():
	health = Health.new()
	health.max_health = 5
	add_child(health)
	
func test_initialize_health():
	asserts.is_equal(health.health, 5)
	
func test_set_health():
	health.health = 2
	asserts.is_equal(health.health, 2)

func test_not_set_negative_health():
	health.health = -1
	asserts.is_equal(health.health, 0)

func test_emit_zero_health():
	watch(health, "zero_health")
	health.health = 0
	asserts.signal_was_emitted(health, "zero_health")

func test_emit_health_changed():
	watch(health, "health_changed")
	health.health = 2
	asserts.signal_was_emitted_with_arguments(health, "health_changed", [2])
