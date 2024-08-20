extends GoapAction

class_name GrabWeaponAction

func get_clazz(): return "GrabWeaponAction"


func is_valid() -> bool:
	return WorldState.get_elements("weapon").size() >= 1


func get_cost(blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {
	}


func get_effects() -> Dictionary:
	return {
		"hasWeapon": true
	}


func perform(actor, delta) -> bool:
	var _weapon = WorldState.get_closest_element("weapon", actor)

	if _weapon:
		if _weapon.position.distance_to(actor.position) < 1:
			if actor.grab_weapon(_weapon):
				WorldState.set_state("hasWeapon", true)
				return true
			return false
		else:
			actor.move_to(_weapon.position, delta)

	return false
