class_name DEMGoToCover
extends GoapGoal

func get_clazz(): return "DemGoToCover"


func is_valid(actor) -> bool:
	return WorldState.get_elements("cover").size() >= 1 and actor.get_state("threat", 0) > 25


func priority(actor) -> int:
	return 10 if actor.get_state("threat", 0) > 75 else 1

func get_desired_state(_actor) -> Dictionary:
	return {
		"isProtected": true
	}
