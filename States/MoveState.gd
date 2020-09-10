extends Node

class_name MoveState

export var speed = 300
export var acceleration = 1000

export var character_path: NodePath
onready var character: KinematicBody2D = get_node(character_path)

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var gravity_multiplier = 1

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	
	velocity += gravity * gravity_multiplier
	velocity = character.move_and_slide(velocity, Vector2.UP)
