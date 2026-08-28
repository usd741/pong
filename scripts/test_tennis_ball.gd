extends RigidBody2D

@export var count_time: float = 4
@export var shoot_speed: float = 500



func _ready() -> void:
	print("BALL SCRIPT STARTED")
	linear_damp = 0.0 #making dump free to not lost speed
	gravity_scale = 0.0 #disabling gravity to avoid speed lost
	contact_monitor = true #enabling contact monitor
	max_contacts_reported = 4 #how much contacts stored
	
	
	
	await get_tree().create_timer(count_time).timeout #waiting 4 seconds
	
	#generating random shoot angle	
	var random_angle: float = randf() * TAU
	print("ANGLE SET ", random_angle)
	
	linear_velocity = Vector2.from_angle(random_angle) * shoot_speed

func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * shoot_speed
	print("CURRENT SPEED: ", shoot_speed)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		if collider:
			var contact_point = state.get_contact_collider_position(i)
			var normal = state.get_contact_local_normal(i)
			linear_velocity = linear_velocity.bounce(normal) #reflecting speed
			#applying rotation and its attitude to bounce
			if has_node("SpinComponent"):
				$SpinComponent.apply_spin(contact_point, normal)
			#normalizing speed (saving the module, direction already chanhed via spin)
			linear_velocity = linear_velocity.normalized() * shoot_speed


#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print("contacts: ", state.get_contact_count())
	#checking the contacts in current frame
	#for i in range(state.get_contact_count()):
	#	var collider = state.get_contact_collider_object(i)
		#if collision happens
	#	if collider:
			#getting surface normal (bounce direction)
	#		var normal = state.get_contact_local_normal(i)
			#reflecting speed relatively to normal
	#		linear_velocity = linear_velocity.bounce(normal)
			#restoring the speed (bounce can change a bit the module)
	#		linear_velocity = linear_velocity.normalized() * shoot_speed
			
			#debug
	#		print("COLLISION with", collider.name, " | SPEED: ", linear_velocity.length())
