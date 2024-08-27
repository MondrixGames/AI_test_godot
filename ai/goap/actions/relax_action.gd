extends GoapAction

class_name RelaxAction

func get_clazz(): return "RelaxAction"


func is_valid(actor) -> bool:
	return actor.get_state("isThreatened", true)


func get_cost(_blackboard) -> int:
	return 0


func get_preconditions(_actor) -> Dictionary:
	return {
		"isThreatened": true
	}


func get_effects(_actor) -> Dictionary:
	return {
		"isChill": true,
	}


func perform(actor, delta) -> bool:
	if actor.is_chill():
		return true
	return false
