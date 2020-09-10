extends TextureRect

onready var width = texture.get_width()

var value = 1 setget set_value

func _ready():
	expand = true # to allow texture to shrink to 0

func set_value(v: int) -> void:
	value = v
	rect_size.x = v * width
