extends Node2D

class_name Weapon

onready var animation := $AnimationPlayer

func _ready():
	animation.connect("animation_finished", self, "animation_finished")


func attack():
	animation.play("Attack")


func animation_finished(anim_name: String) -> void:
	if anim_name == "Attack":
		animation.play("Idle")
