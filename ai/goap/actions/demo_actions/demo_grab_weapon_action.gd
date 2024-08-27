class_name DEMGrabWeaponAction
extends GoapAction

func get_clazz(): return "DemGrabWeaponAction"

func is_valid(actor) -> bool:
	return WorldState.get_elements("weapon").size() > 0 and !actor.get_state("hasWeapon", false)


func get_cost(blackboard) -> int:
	if blackboard.has("position"):
		var closest_weapon = WorldState.get_closest_element("weapon", blackboard)
		return int(closest_weapon.position.distance_to(blackboard.position) / 2)
	return 100


func get_preconditions(_actor) -> Dictionary:
	return {
	}


func get_effects(_actor) -> Dictionary:
	return {
		"hasWeapon": true
	}


func perform(actor, delta) -> bool:
	var _weapon = WorldState.get_closest_element("weapon", actor)
	if _weapon:
		#if object_changed(_weapon):
			#request_new_plan_to_agent(actor)
		if _weapon.position.distance_to(actor.position) < 1:
			if actor.grab_weapon(_weapon):
				actor.set_state("hasWeapon", true)
				return true
			return false
		else:
			actor.move_to(_weapon.position, delta)
	#else:
		#request_new_plan_to_agent(actor)
	return false
