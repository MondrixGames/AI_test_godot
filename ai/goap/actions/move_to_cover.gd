extends GoapAction

class_name MoveToCoverAction

func get_clazz(): return "MoveToCoverAction"


func is_valid() -> bool:
	return WorldState.get_elements("cover").size() >= 1 and WorldState.get_state("isThreatened", true)


func get_cost(blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		"isThreatened": false
	}


func perform(actor, delta) -> bool:
	var _cover = WorldState.get_closest_element("cover", actor)

	if _cover:
		if _cover.position.distance_to(actor.position) < 1:
			if actor.is_chill():
				WorldState.set_state("isThreatened", false)
				return true
			return false
		else:
			actor.move_to(_cover.position, delta)

	return false
