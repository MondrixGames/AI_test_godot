extends GoapAction

class_name ShootPlayerAction

func get_clazz(): return "ShootPlayerAction"


func is_valid() -> bool:
	return WorldState.get_elements("player").size() >= 1


func get_cost(blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {
		"hasWeapon": true
	}


func get_effects() -> Dictionary:
	return {
		"playerIsAlive": false,
	}


func perform(actor, delta) -> bool:
	var _player = WorldState.get_closest_element("player", actor)

	if _player:
		if _player.position.distance_to(actor.position) < 5:
				if actor.shoot_player(_player):
					WorldState.set_state("playerIsAlive", false)
					WorldState.set_state("hasWeapon", false)
					return true
				return false
		else:
			actor.move_to(_player.position, delta)

	return false
