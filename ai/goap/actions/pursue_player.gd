extends GoapAction

class_name PursuePlayerAction

func get_clazz(): return "PursuePlayerAction"


func is_valid(actor) -> bool:
	return WorldState.get_elements("player").size() >= 1 and actor.get_state("playerIsAlive", true)


func get_cost(blackboard) -> int:
	if blackboard.has("position"):
		var closest_player = WorldState.get_closest_element("player", blackboard)
		return int(closest_player.position.distance_to(blackboard.position) / 2)
	return 5


func get_preconditions(_actor) -> Dictionary:
	return {}


func get_effects(_actor) -> Dictionary:
	return {
		"playerIsAlive": false
	}


func perform(actor, delta) -> bool:
	var _player = WorldState.get_closest_element("player", actor)

	if _player:
		if _player.position.distance_to(actor.position) < 1:
				if actor.kill_player():
					actor.set_state("playerIsAlive", false)
					return true
				return false
		else:
			actor.move_to(_player.position, delta)

	return false
