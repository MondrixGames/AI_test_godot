extends GoapGoal

class_name GrabWeaponGoal

func get_clazz(): return "GrabWeaponGoal"

func is_valid(actor) -> bool:
	return WorldState.get_elements("weapon").size() > 0 and !actor.get_state("hasWeapon", false)


func priority(actor) -> int:
	var _closest_weapon = WorldState.get_closest_element("weapon", actor)
	return 3 if _closest_weapon.position.distance_to(actor.position) < 10 else 1


func get_desired_state(_actor) -> Dictionary:
	return {
		"hasWeapon": true
	}
