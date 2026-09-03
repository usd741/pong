class_name GrabComponent
extends Node

@export var actor: RigidBody2D
@export var shoot_speed: float = 750.0

@export var area: Area2D
@export var shape: CollisionShape2D

@export var grab_offset: float = 50.0
@export var aim_direction_x: float = 1.0

@export_enum("p1_grab", "p2_grab") var grab_key: String
@export_enum("p1_up", "p2_up") var aim_up_key: String
@export_enum("p1_down", "p2_down") var aim_down_key: String

var is_grabbing: bool = false
var just_released: bool = false

var grabbed_actor: RigidBody2D = null
var aim_direction: Vector2 = Vector2.RIGHT

var original_parent: Node

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	print("Area2d shape: ", area.get_child(0).shape)
	print("Area2d mask: ", area.collision_mask)

func _process(delta: float) -> void:
	if not is_grabbing:
		return
	var input_y: = Input.get_axis(aim_up_key, aim_down_key)
	aim_direction = Vector2(aim_direction_x, input_y).normalized()
	
	 #temporary debug
	if is_grabbing:
		print("Aim: ", aim_direction)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(grab_key) and grabbed_actor != null and not is_grabbing:
		_grab_actor()
	elif Input.is_action_just_pressed(grab_key) and is_grabbing:
		_release_actor()

func _grab_actor():
	is_grabbing = true
	actor.freeze = true
	grabbed_actor.freeze = true
	grabbed_actor.is_grabbed = true #switching on the "grabbed status"
	original_parent = grabbed_actor.get_parent() #remembering parent node
	grabbed_actor.reparent(actor) #making a child of actor
	grabbed_actor.position = Vector2.ZERO  + Vector2(grab_offset, 0) #center by player
	print("GRAB STARTED")

func _release_actor():
	is_grabbing = false
	actor.freeze = false
	grabbed_actor.freeze = false
	grabbed_actor.is_grabbed = false #switching on the "grabbed status"
	if original_parent:
		grabbed_actor.reparent(original_parent)
	else:
		grabbed_actor.reparent(get_tree().root) #returning to scene root
	grabbed_actor.global_position = actor.global_position + Vector2(grab_offset, 0) #saving position
	var shoot_direction = aim_direction.normalized()
	grabbed_actor.linear_velocity = shoot_direction * shoot_speed
	print("BALL SHOT with speed: ", shoot_speed)
	print("GRAB RELEASED")
	grabbed_actor = null
	just_released = true
	
	#letting to grab again
	await get_tree().create_timer(1.5).timeout
	just_released = false

func _on_body_entered(body: Node) -> void:
	#ignoring if just_released = true
	if just_released or grabbed_actor != null:
		return
	
	if body is RigidBody2D:
		grabbed_actor = body as RigidBody2D
		print("Ball detected ")
