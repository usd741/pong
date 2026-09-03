extends Node

var win_score: int = 5

@export var ui_scene: Node #select the ui scene
@export var ball_spawner: BallSpawnerComponent

@onready var score_label_p1 = ui_scene.get_node("%LabelP1Score")
@onready var score_label_p2 = ui_scene.get_node("%LabelP2Score")

#current round scores
var round_score_p1: int = 0
var round_score_p2: int = 0



func _ready() -> void:
	if ui_scene:
		score_label_p1 = ui_scene.get_node("%LabelP1Score")
		score_label_p2 = ui_scene.get_node("%LabelP2Score")
	if ball_spawner:
		ball_spawner.ball_scored.connect(_on_ball_exited)



func _on_ball_exited(side: int) -> void:
	if side == 1:
		print("Мяч улетел вправо: +очко Игроку №1")
		round_score_p1 += 1
	else:
		print("Мяч улетел влево: +очко Игроку №2")
		round_score_p2 += 1
	update_score_ui()
	check_round_end()


func update_score_ui() -> void:
	score_label_p1.text = str(round_score_p1)
	score_label_p2.text = str(round_score_p2)
	
func check_round_end():
	if round_score_p1 >= win_score:
		GlobalGameManager.add_round_result(1, round_score_p1, round_score_p2)
	elif round_score_p2 >= win_score:
		GlobalGameManager.add_round_result(2, round_score_p1, round_score_p2)
