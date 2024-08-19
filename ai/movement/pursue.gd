extends Seek

class_name Pursue

## The maximum prediction time.
@export var maxPrediction: float = 0.0
@export var purTarget: CharacterBody3D

# OVERRIDES the target data in seek (in other words this class has
# two bits of data called target: Seek.target is the superclass
# target which will be automatically calculated and shouldn’t be
# set, and Pursue.target is the target we’re pursuing).

func get_steering() -> SteeringOutput:
	# 1. Calculate the target to delegate to seek
	# Work out the distance to target.
	var direction: Vector3 = purTarget.position - character.position
	var distance: float = direction.length()
	var prediction: float = 0.0
	# Work out our current speed.
	var speed: float = character.velocity.length()
	
	# Check if speed gives a reasonable prediction time.
	if speed <= distance / maxPrediction:
		prediction = maxPrediction
	# Otherwise calculate the prediction time.
	else:
		prediction = distance / speed
	
	# Put the target together.
	target = purTarget
	target.position += purTarget.velocity * prediction
	
	# 2. Delegate to seek.
	return super.get_steering()
	
