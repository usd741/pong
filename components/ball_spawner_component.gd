class_name BallSpawnerComponent
extends Node

signal ball_scored(side: int) #1 = right, 2 = left

@export var ball_scene: PackedScene #select ball scene
@export var spawn_position: Vector2 = Vector2(320, 240)

var ball: RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_ball()

func spawn_ball():
	if ball:
		ball.queue_free()
	
	ball = ball_scene.instantiate()
	add_child(ball)
	ball.global_position = spawn_position
	ball.ball_exited_screen.connect(_on_ball_exited)
	
	if ball.has_method("prepare_and_shoot"):
		ball.prepare_and_shoot()


func _on_ball_exited():
	var side = 1 if ball.global_position.x > 0 else 2
	ball_scored.emit(side)
	spawn_ball()
