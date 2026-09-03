class_name ShotDirectionComponent
extends Node

@export var parent: RigidBody2D
@export var grab_component: GrabComponent
@export var sprite: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.visible = grab_component.is_grabbing
	if grab_component.is_grabbing:
		sprite.rotation = grab_component.aim_direction.angle()
