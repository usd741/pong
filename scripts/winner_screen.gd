extends Control


@onready var label_winner_name: Label = %LabelWinnerName
@onready var label_round_score: Label = %LabelWinnerScore

var winner: int = 0
var score_p1: int = 0
var score_p2: int = 0
var total_p1: int = 0
var total_p2: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	update_ui()



func set_data(winner: int, score_p1: int, score_p2: int, total_p1: int, total_p2: int) -> void:
	self.winner = winner
	self.score_p1 = score_p1
	self.score_p2 = score_p2
	self.total_p1 = total_p1
	self.total_p2 = total_p2
	update_ui()

func update_ui() -> void:
	label_winner_name.text = "Игрок " + str(winner)
	label_round_score.text = str(score_p1) + " - " + str(score_p2)
