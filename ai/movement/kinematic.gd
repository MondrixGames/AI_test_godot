extends CharacterBody3D

class_name Kinematic

var rotationVel: float = 0.0

@export var movement_behaviour: Node

func _physics_process(delta: float) -> void:
	var steering = movement_behaviour.get_steering()
	var maxSpeed = movement_behaviour.maxSpeed
	
	update(steering, maxSpeed, delta)
	move_and_slide()

func update(steering: SteeringOutput, maxSpeed: float, delta: float):
	# Update the position and orientation.
	position += velocity * delta
	rotation.y += rotationVel * delta
	
	# And the velocity and rotation.
	velocity += steering.linear * delta
	rotationVel += steering.angular * delta
	
	# Check for speeding and clip.
	if velocity.length() > maxSpeed:
		velocity = velocity.normalized()
		velocity *= maxSpeed
