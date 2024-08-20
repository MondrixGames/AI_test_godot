#
# Action Contract
#
extends Node

class_name GoapAction


#
# This indicates if the action should be considered or not.
#
# Currently I'm using this method only during planning, but it could
# also be used during execution to abort the plan in case the world state
# does not allow this action anymore.
#
func is_valid(_actor) -> bool:
	return true


#
# Action Cost. This is a function so it handles situational costs, when the world
# state is considered when calculating the cost.
#
# Check "./actions/chop_tree.gd" for a situational cost example.
#
func get_cost(_blackboard) -> int:
	return 1000

#
# Action requirements.
# Example:
# {
#   "has_wood": true
# }
#
func get_preconditions(_actor) -> Dictionary:
	return {}


#
# What conditions this action satisfies
#
# Example:
# {
#   "has_wood": true
# }
func get_effects(_actor) -> Dictionary:
	return {}


#
# Action implementation called on every loop.
# "actor" is the NPC using the AI
# "delta" is the time in seconds since last loop.
#
# Returns true when the task is complete.
#
# Check "./actions/chop_tree.gd" for example.
#
# I decided to have actions owning their logic, but this
# is up to you. You could have another script to handle this
# or even let your NPC decide how to handle the action. In other words,
# your NPC could just receive the action name and decide what to do.
#
func perform(_actor, _delta) -> bool:
	return false

# Si hay alguna acción que no se puede realizar en ningún momento, esta función
# pide un nuevo plan al Goap.get_action_planner().get_plan()

func request_new_plan_to_agent(actor):
	for child in actor.get_children():
		if child is GoapAgent:
			child.request_new_plan()
	return null
