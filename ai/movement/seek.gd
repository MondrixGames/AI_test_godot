extends Node

class_name Seek

@export var character: Kinematic
@export var target: CharacterBody3D

@export var maxAcceleration: float = 0.3
@export var maxSpeed: float = 3.0


func get_steering() -> SteeringOutput:
	var result: SteeringOutput = SteeringOutput.new()
	
	# Get the direction to the target.
	result.linear = target.position - character.position
	
	# Give full acceleration along this direction.
	result.linear = result.linear.normalized()
	print(result.linear)
	result.linear *= maxAcceleration
	result.angular = 0
	return result
