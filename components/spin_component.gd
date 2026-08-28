class_name SpinComponent
extends Node

@export var actor: RigidBody2D
@export var spin_factor: float = 0.5 #how strong spinning will be

var angular_velocity: float = 0.0 #current angular speed

func _ready() -> void:
	#connecting to ball collisions
	if actor:
		actor.contact_monitor = true
		actor.max_contacts_reported = 4


func _physics_process(delta: float) -> void:
	angular_velocity *= 0.99 #slow rotation down



func apply_spin(contact_point: Vector2) -> void:
	#vector from center of the ball to the contact point
	var contact_vector = contact_point - actor.global_position
	#offseting Y (how strong the hit higher or lower about center)
	var offset_y = contact_vector.y
	
	#calculating angle speed (aplying from current hit, no cumulative)
	#using minus, to convert top hit to rotation
	
	#calculating offset of hit place relative to center of object
	var offset_from_center = contact_point.y - actor.global_position.y
	angular_velocity += offset_from_center * spin_factor
	
	#rotation affecting to bounce
	var spin_impulse = Vector2(angular_velocity * 0.1, 0)
	actor.linear_velocity += spin_impulse
	
	print("SPIN: ", angular_velocity, " | IMPULSE: ", spin_impulse)
	

#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
#	for i in range(state.get_contact_count()):
#		var collider = state.get_contact_collider_object(i)
#		if collider:
#			var contact_point = state.get_contact_local_position(i)
#			var normal = state.get_contact_local_normal(i)
#			
			#calculating rotation on an object hit place
			#if hit above the center - topspin (positive rotation)
			#if hit below the center - backspin (negative rotation)
#			var offset_from_center = contact_point.y - actor.global_position.y
#			angular_velocity += offset_from_center * spin_factor
			
			#affecting rotation to bounce
			#adding horizontal power depending on rotation
#			var spin_impulse = Vector2(angular_velocity * 0.1, 0)
#			actor.linear_velocity += spin_impulse
			
#			print("SPIN: ", angular_velocity, " | ADDED IMPULSE: ", spin_impulse)
	
#	angular_velocity *= 0.99 #slowly stopping rotation
