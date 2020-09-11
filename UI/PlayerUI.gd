extends Control

onready var hearts_empty = $HeartsEmpty
onready var hearts_full = $HeartsFull

func set_hearts(hp: int) -> void:
	hearts_full.set_value(hp)

func set_max_hearts(hp: int) -> void:
	hearts_empty.set_value(hp)
