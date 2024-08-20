extends GoapGoal

class_name StaySafeGoal

func get_clazz(): return "StaySafeGoal"


func is_valid(actor) -> bool:
	return WorldState.get_elements("cover").size() >=1 and actor.get_state("isThreatened", true)


func priority(_actor) -> int:
	return 1


func get_desired_state(_actor) -> Dictionary:
	return {
		"isThreatened": false
	}
