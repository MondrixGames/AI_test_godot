extends GoapAction

class_name MoveToCoverAction

func get_clazz(): return "MoveToCoverAction"


func is_valid(actor) -> bool:
	return WorldState.get_elements("cover").size() >= 1 and actor.get_state("isThreatened", true)


func get_cost(_blackboard) -> int:
	return 1


func get_preconditions(_actor) -> Dictionary:
	return {}


func get_effects(_actor) -> Dictionary:
	return {
		"isThreatened": false
	}


func perform(actor, delta) -> bool:
	var _cover = WorldState.get_closest_element("cover", actor)

	if _cover:
		if _cover.position.distance_to(actor.position) < 1.5:
			if await actor.covering(_cover):
				actor.set_state("isThreatened", false)
				return true
			return false
		else:
			actor.move_to(_cover.position, delta)

	return false
