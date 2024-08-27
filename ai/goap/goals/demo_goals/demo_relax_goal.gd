class_name DEMRelaxGoal
extends GoapGoal

func get_clazz(): return "DemRelaxGoal"

func is_valid(_actor) -> bool:
	return true

func priority(_actor) -> int:
	return 1

func get_desired_state(_actor) -> Dictionary:
	return {
		"threat":0
	}
