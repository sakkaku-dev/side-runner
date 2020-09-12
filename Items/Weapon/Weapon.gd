extends Node2D

class_name Weapon

onready var animation := $AnimationPlayer
onready var impact_sound := $Impact
onready var hit_area := $HitArea

func _ready():
	if animation.connect("animation_finished", self, "animation_finished"):
		print("animation_finished could not be connected")
	if hit_area.connect("area_entered", self, "on_hit"):
		print("on_hit could not be connected")


func attack():
	animation.play("Attack")


func animation_finished(anim_name: String) -> void:
	if anim_name == "Attack":
		animation.play("Idle")


func on_hit(_area):
	impact_sound.play(0)

func delete_weapon():
	if impact_sound.playing:
		impact_sound.connect("finished", self, "queue_free")
		hide()
	else:
		queue_free()
