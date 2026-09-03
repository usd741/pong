extends Node

#total score between rounds

var total_score_p1: int = 0
var total_score_p2: int = 0

func _ready() -> void:
	print("Global manager is active")


func add_round_result(winner: int, score_p1: int, score_p2: int) -> void:
	print("Raund finished! Player: ", winner, " won!")
	print("Round score: ", score_p1, " - ", score_p2)
	
	if winner == 1:
		total_score_p1 += 1
	else:
		total_score_p2 += 1
	
	print("Total score: Player 1 - ", total_score_p1, ", Player 2 - ", total_score_p2)
