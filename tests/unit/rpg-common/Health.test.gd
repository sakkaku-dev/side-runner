extends WAT.Test

var health: Health

func pre():
	health = Health.new()
	health.max_health = 5
	watch(health, "health_changed")
	watch(health, "max_health_changed")
	add_child(health)
	
func test_initialize_health():
	asserts.is_equal(health.health, 5)
	
func test_initial_health_change_emit():
	asserts.signal_was_emitted_with_arguments(health, "health_changed", [5])

func test_initial_max_health_change_emit():
	asserts.signal_was_emitted_with_arguments(health, "max_health_changed", [5])
	
func test_set_health():
	health.health = 2
	asserts.is_equal(health.health, 2)
	
func test_not_set_above_max_health():
	health.max_health = 5
	health.health = 10
	asserts.is_equal(health.health, 5)

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

func test_emit_health_changed_on_zero():
	watch(health, "health_changed")
	health.health = 0
	asserts.signal_was_emitted_with_arguments(health, "health_changed", [0])
	
func test_set_max_health():
	health.max_health = 2
	asserts.is_equal(health.max_health, 2)

func test_not_set_max_health_below_one():
	health.max_health = 0
	asserts.is_equal(health.max_health, 1)

func test_emit_max_health_changed():
	watch(health, "max_health_changed")
	health.max_health = 2
	asserts.signal_was_emitted_with_arguments(health, "max_health_changed", [2])
