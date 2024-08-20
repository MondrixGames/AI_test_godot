extends GoapGoal

class_name PlayerIsDeadGoal

func get_clazz(): return "PlayerIsDeadGoal"


func is_valid(actor) -> bool:
	return WorldState.get_elements("player").size() >= 1 and actor.get_state("playerIsAlive", true)


func priority(_actor) -> int:
	return 2


func get_desired_state(_actor) -> Dictionary:
	return {
		"playerIsAlive": false
	}
