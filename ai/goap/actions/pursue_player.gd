extends GoapAction

class_name PursuePlayerAction

func get_clazz(): return "PursuePlayerAction"


func is_valid() -> bool:
	return WorldState.get_elements("player").size() >= 1


func get_cost(blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		"playerIsAlive": false
	}


func perform(actor, delta) -> bool:
	var _player = WorldState.get_closest_element("player", actor)

	if _player:
		if _player.position.distance_to(actor.position) < 1:
				if actor.kill_player():
					WorldState.set_state("playerIsAlive", false)
					return true
				return false
		else:
			actor.move_to(_player.position, delta)

	return false
