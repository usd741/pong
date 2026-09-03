class_name SpinComponent
extends Node

@export var actor: RigidBody2D
@export var visual_actor: Node2D
@export var spin_factor: float = 0.01 #rotation strength

var spin_direction: float = 1.0

func _process(delta: float) -> void:
	var speed = actor.linear_velocity.length()
	visual_actor.rotation += speed * spin_factor * spin_direction * delta

func _ready() -> void:
	#connecting actor's body entered
	actor.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node) -> void:
	spin_direction *= -1
	print("SPIN DIRECTION IS: ", spin_direction)
