class_name DEMGrabWeapon
extends GoapGoal

func get_clazz(): return "DemGrabWeapon"


func is_valid(actor) -> bool:
	return WorldState.get_elements("weapon").size() >= 1 and !actor.get_state("hasWeapon", false)


func priority(actor) -> int:
	var closest_weapon = WorldState.get_closest_element("weapon", actor)
	return 4 if closest_weapon.position.distance_to(actor.position) < 5 else 1

func get_desired_state(_actor) -> Dictionary:
	return {
		"hasWeapon": true
	}
