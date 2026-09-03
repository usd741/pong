extends Node

var win_score: int = 5

@export var ui_scene: Node #select the ui scene
@export var ball_scene: PackedScene #select ball scene


@onready var score_label_p1 = ui_scene.get_node("%LabelP1Score")
@onready var score_label_p2 = ui_scene.get_node("%LabelP2Score")


#current round scores
var round_score_p1: int = 0
var round_score_p2: int = 0
var ball: RigidBody2D

func _ready() -> void:
	if ui_scene:
		score_label_p1 = ui_scene.get_node("%LabelP1Score")
		score_label_p2 = ui_scene.get_node("%LabelP2Score")
	
	#spawning first ball on the scene
	if ball_scene:
		ball = ball_scene.instantiate()
		add_child(ball)
		ball.global_position = Vector2(320, 240)
		ball.ball_exited_screen.connect(_on_ball_exited)
		#call shoot function, if it exist in ball script
		if ball.has_method("prepare_and_shoot"):
			ball.prepare_and_shoot()

func _on_ball_exited() -> void:
	#allocating ball's side position
	if ball.global_position.x < 0:
		print("Мяч улетел влево: +очко Игроку №2")
		round_score_p2 += 1
	else:
		print("Мяч улетел вправо: +очко Игроку №1")
		round_score_p1 += 1
	update_score_ui()
	check_round_end()
	reset_ball()

func reset_ball():
	print("Reset ball starts")
	ball.queue_free()
	var new_ball =ball_scene.instantiate()
	add_child(new_ball)
	new_ball.global_position = Vector2(320, 240)
	ball = new_ball
	ball.ball_exited_screen.connect(_on_ball_exited)
	ball.prepare_and_shoot()

func update_score_ui() -> void:
	score_label_p1.text = str(round_score_p1)
	score_label_p2.text = str(round_score_p2)
	
func check_round_end():
	if round_score_p1 >= win_score:
		GlobalGameManager.add_round_result(1, round_score_p1, round_score_p2)
	elif round_score_p2 >= win_score:
		GlobalGameManager.add_round_result(2, round_score_p1, round_score_p2)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
