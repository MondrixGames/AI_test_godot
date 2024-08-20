extends GoapAction

class_name GrabWeaponAction

func get_clazz(): return "GrabWeaponAction"


func is_valid(_actor) -> bool:
	return WorldState.get_elements("weapon").size() > 0


func get_cost(blackboard) -> int:
	if blackboard.has("position"):
		var closest_weapon = WorldState.get_closest_element("weapon", blackboard)
		return int(closest_weapon.position.distance_to(blackboard.position) / 2)
	return 3


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
		if _weapon.position.distance_to(actor.position) < 1:
			if actor.grab_weapon(_weapon):
				actor.set_state("hasWeapon", true)
				return true
			return false
		else:
			actor.move_to(_weapon.position, delta)
	else:
		request_new_plan_to_agent(actor)
	return false

func request_new_plan_to_agent(actor):
	for child in actor.get_children():
		if child is GoapAgent:
			child.request_new_plan()
	return null
	
