extends GoapAction

class_name CoverToStandAction

func get_clazz(): return "CoverToStandAction"


func is_valid(actor) -> bool:
	return !actor.get_state("isThreatened", false)


func get_cost(_blackboard) -> int:
	return 0


func get_preconditions(_actor) -> Dictionary:
	return {
		"isThreatened": false
	}


func get_effects(_actor) -> Dictionary:
	return {
		"isChill": true
	}


func perform(actor, delta) -> bool:
	if await actor.is_chill_from_cover():
		return true
	return false
