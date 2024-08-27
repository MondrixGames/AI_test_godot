class_name DEMKillPlayerGoal
extends GoapGoal

func get_clazz(): return "DemKillPlayerGoal"


func is_valid(actor) -> bool:
	return WorldState.get_elements("player").size() >= 1 and actor.get_state("playerIsAlive", true)


func priority(actor) -> int:
	var closest_player = WorldState.get_closest_element("player", actor)
	return 3 if closest_player.position.distance_to(actor.position) < 10 else 1

func get_desired_state(_actor) -> Dictionary:
	return {
		"playerIsAlive": false
	}
