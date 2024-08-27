class_name DEMWanderAction
extends GoapAction

func get_clazz(): return "DemWanderAction"

func is_valid(_actor) -> bool:
	return true

func get_cost(_blackboard) -> int:
	return 0

func get_preconditions(_actor) -> Dictionary:
	return {
		
	}

func get_effects(_actor) -> Dictionary:
	return {
		"isPatrolling": true
	}

func perform(actor, delta) -> bool:
	if actor.wander_action():
		return true
	return false
