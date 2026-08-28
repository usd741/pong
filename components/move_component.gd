class_name MoveComponent
extends Node

@export var actor: RigidBody2D
@export var velocity: Vector2


func _process(delta: float) -> void:
	actor.angular_velocity = 0 #setting the angle to 0 to avoid rotation
	actor.linear_velocity = velocity
