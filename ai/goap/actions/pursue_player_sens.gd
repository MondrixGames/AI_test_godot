extends GoapAction

class_name PursuePlayerSensAction

func get_clazz(): return "PursuePlayerSensAction"

func is_valid(actor) -> bool:
	return actor.get_state("playerIsAlive", true)


func get_cost(blackboard) -> int:
	return 0


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
			actor.look_at(_player.position, Vector3.UP)

	return false
