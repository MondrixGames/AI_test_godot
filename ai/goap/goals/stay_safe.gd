extends GoapGoal

class_name StaySafeGoal

func get_clazz(): return "StaySafeGoal"


func is_valid() -> bool:
	return WorldState.get_elements("cover").size() >=1 and WorldState.get_state("isThreatened", true)


func priority() -> int:
	return 1


func get_desired_state() -> Dictionary:
	return {
		"isThreatened": false
	}
