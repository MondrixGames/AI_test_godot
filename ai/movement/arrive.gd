extends Node

class_name Arrive

@export_group("Kinematic Nodes")
@export var character: Kinematic
@export var target: CharacterBody3D

@export_group("Movement Variables")
@export var maxAcceleration: float
@export var maxSpeed: float

@export_group("Radius Variables")
## The radius for arriving at the target
@export var targetRadius: float

## The radius for beginning to slow down
@export var slowRadius: float

## The time over to achieve target speed
var timeToTarget: float = 0.1

var targetSpeed: float = 0.0
var targetVelocity: Vector3 = Vector3.ZERO

func get_steering() -> SteeringOutput:
	var result = SteeringOutput.new()
	
	# Get the direction to the target
	var direction: Vector3 = target.position - character.position
	var distance: float = direction.length()
	
	# Check if we are there, return no steering
	if distance < targetRadius:
		return null
	# If we are outside the slowRadius, then move at maxSpeed.
	if distance > slowRadius:
		targetSpeed = maxSpeed
	# Otherwise calculate a scaled speed.
	else:
		targetSpeed = maxSpeed * distance / slowRadius
		target.velocity = direction
		target.velocity = target.velocity.normalized()
		target.velocity *= targetSpeed
		
		# Acceleration tries to get to the target velocity.
		result.linear = targetVelocity - character.velocity
		result.linear /= timeToTarget
		
		# Check if the acceleration is too fast.
		if result.linear.length() > maxAcceleration:
			result.linear.normalized()
			result.linear *= maxAcceleration
		result.angular = 0
	return result
