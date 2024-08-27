class_name DEMPatrolGoal
extends GoapGoal

func get_clazz(): return "DemPatrolGoal"

func is_valid(_actor) -> bool:
	return true

func priority(_actor) -> int:
	return 0

func get_desired_state(_actor) -> Dictionary:
	return {
		"isPatrolling": true
	}
