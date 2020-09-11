extends Node2D

class_name Weapon

onready var animation := $AnimationPlayer

func _ready():
	if animation.connect("animation_finished", self, "animation_finished"):
		print("Error connection signal")


func attack():
	animation.play("Attack")


func animation_finished(anim_name: String) -> void:
	if anim_name == "Attack":
		animation.play("Idle")
