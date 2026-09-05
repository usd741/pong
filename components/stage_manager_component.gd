class_name StageManagerComponent
extends Node

@export var winner_screen: PackedScene
@export var next_stage_1: PackedScene
@export var next_stage_2: PackedScene

@export var round_manager: Node

var current_scene: Node = null

func _ready() -> void:
	#listening on whenever round ends
	round_manager.round_ended.connect(_on_round_ended)


func _on_round_ended(winner: int, score_p1: int, score_p2: int) -> void:
	show_winner_screen()
	
	#connection to total score in global manager
	var total_score_p1 = GlobalGameManager.total_score_p1
	var total_score_p2 = GlobalGameManager.total_score_p2
	
	#sending data to winner screen
	if current_scene and current_scene.has_method("set_data"):
		current_scene.set_data(winner, score_p1, score_p2, total_score_p1, total_score_p2)

func show_winner_screen():
	if current_scene:
		current_scene.queue_free()
	var instance = winner_screen.instantiate()
	add_child(instance)
	current_scene = instance
	get_tree().paused = true
