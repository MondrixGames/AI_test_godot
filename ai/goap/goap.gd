# This class is an Autoload accessible globaly.
# It initialises a GoapActionPlanner with the available
# actions.
#
# In your game, you might want to have different planners
# for different enemy/npc types, and even change the set
# of actions in runtime.
#
# This example keeps things simple, creating only one planner
# with pre-defined actions.
#
extends Node

var _action_planner =  GoapActionPlanner.new()

func _ready():
	_action_planner.set_actions([
		PursuePlayerAction.new(),
		MoveToCoverAction.new(),
		GrabWeaponAction.new(),
		ShootPlayerAction.new()
	])


func get_action_planner() -> GoapActionPlanner:
	return _action_planner
