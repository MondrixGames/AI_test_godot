extends GoapAction

class_name ShootPlayerAction

func get_clazz(): return "ShootPlayerAction"


func is_valid(_actor) -> bool:
	return WorldState.get_elements("player").size() >= 1


func get_cost(_blackboard) -> int:
	return 1


func get_preconditions(_actor) -> Dictionary:
	return {
		"hasWeapon": true
	}


func get_effects(_actor) -> Dictionary:
	return {
		"playerIsAlive": false,
	}


func perform(actor, delta) -> bool:
	var _player = WorldState.get_closest_element("player", actor)

	if _player:
		if _player.position.distance_to(actor.position) < 8:
				if actor.shoot_player(_player):
					actor.set_state("playerIsAlive", false)
					actor.set_state("hasWeapon", false)
					return true
				return false
		else:
			actor.move_to(_player.position, delta)

	return false
