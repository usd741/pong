extends RigidBody2D

signal ball_exited_screen

@export var count_time: float = 4
@export var shoot_speed: float = 200


var is_respawning: bool = false
var is_grabbed: bool = false

func _ready() -> void:
	var screen_notifier = $VisibleOnScreenNotifier2D
	screen_notifier.screen_exited.connect(_on_screen_exited)
	

func _physics_process(delta: float) -> void:
	#skipping speed normalizing if grabbed
	if is_grabbed:
		return
	#normalizing speed if not
	var current_speed = linear_velocity.length()
	#normalizing only if speed below shoot_speed (after bounce)
	if current_speed < shoot_speed and current_speed >0:
		linear_velocity = linear_velocity.normalized() * shoot_speed

func _on_screen_exited() -> void:
	if is_respawning:
		return
	print("Ball leaves the screen")
	ball_exited_screen.emit()

func prepare_and_shoot():
	is_respawning = true
	print("BALL SCRIPT STARTED")
	linear_damp = 0.0 #making dump free to not lost speed
	gravity_scale = 0.0 #disabling gravity to avoid speed lost
	contact_monitor = true #enabling contact monitor
	max_contacts_reported = 4 #how much contacts stored
		
	await get_tree().create_timer(count_time).timeout #waiting n seconds
	is_respawning = false
	#generating random shoot angle	
	var random_angle: float = randf_range(0.45, 0.5) * TAU
	print("ANGLE SET ", random_angle)
	
	linear_velocity = Vector2.from_angle(random_angle) * shoot_speed
