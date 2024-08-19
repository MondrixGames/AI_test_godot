extends GoapGoal

class_name PlayerIsDeadGoal

func get_clazz(): return "PlayerIsDeadGoal"


func is_valid() -> bool:
	return WorldState.get_elements("player").size() >= 1 and WorldState.get_state("playerIsAlive", true)


func priority() -> int:
	return 1


func get_desired_state() -> Dictionary:
	return {
		"playerIsAlive": false
	}
