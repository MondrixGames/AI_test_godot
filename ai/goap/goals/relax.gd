extends GoapGoal

class_name RelaxGoal

func get_clazz(): return "RelaxGoal"

# relax will always be available
func is_valid(_actor) -> bool:
	return true


# relax has lower priority compared to other goals
func priority(_actor) -> int:
	return 0

func get_desired_state(_actor) -> Dictionary:
	return {
		"isChill": true
	}
