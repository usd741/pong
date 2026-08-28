class_name MoveInputComponentVertical
extends Node

@export var move_stats: MoveStats
@export var move_component: MoveComponent
@export var button_up: StringName
@export var button_down: StringName


var current_velocity: Vector2
var target_velocity: Vector2


func _input(event: InputEvent) -> void:
	var input_axis = Input.get_axis(button_up, button_down)
	target_velocity = Vector2(0, input_axis * move_stats.speed)
	#move_component.velocity = Vector2(input_axis * move_stats.speed, 0)

func _process(delta: float) -> void:
	current_velocity = current_velocity.move_toward(
		target_velocity,
		move_stats.acceleration * delta)
	move_component.velocity = current_velocity
