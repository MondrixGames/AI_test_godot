#
# This script integrates the actor (NPC) with goap.
# In your implementation you could have this logic
# inside your NPC script.
#
# As good practice, I suggest leaving it isolated like
# this, so it makes re-use easy and it doesn't get tied
# to unrelated implementation details (movement, collisions, etc)
extends Node

class_name GoapAgent

var _goals
var _current_goal
var _current_plan
var _current_plan_step = 0

var _actor

# Time Delay between replans (in seconds)
var _replan_delay = 0.5 #adjust this value as needed
var time_since_last_replan = 0.0

#
# On every loop this script checks if the current goal is still
# the highest priority. if it's not, it requests the action planner a new plan
# for the new high priority goal.
#
func _process(delta):
	time_since_last_replan += delta
	
	if time_since_last_replan >=_replan_delay:
		var goal = _get_best_goal()
		if _current_goal == null or goal != _current_goal:
		# You can set in the blackboard any relevant information you want to use
		# when calculating action costs and status. I'm not sure here is the best
		# place to leave it, but I kept here to keep things simple.
			var blackboard = {
				"position": _actor.position,
				}
				
			for s in _actor._state:
				blackboard[s] = _actor._state[s]
			
			_actor.goal_tag.text = str(goal.get_clazz())
			print("Actor: %s" % _actor.name)
			WorldState.console_message("Actor: %s" % _actor.name)
			_current_goal = goal
			_current_plan = Goap.get_action_planner().get_plan(_actor, _current_goal, blackboard)
			_current_plan_step = 0
		else:
			_follow_plan(_current_plan, delta)

func request_new_plan():
	var blackboard = {
		"position": _actor.position,
	}
	for s in _actor._state:
		blackboard[s] = _actor._state[s]
	_current_plan = Goap.get_action_planner().get_plan(_actor, _current_goal, blackboard)
	_current_plan_step = 0

func init(actor, goals: Array, replan_delay: float):
	_actor = actor
	_goals = goals
	_replan_delay = replan_delay
	time_since_last_replan = randf() * replan_delay # Stagger replans for different agents at the start

#
# Returns the highest priority goal available.
#
func _get_best_goal():
	var highest_priority = null

	for goal in _goals:
		if goal.is_valid(_actor) and (highest_priority == null or goal.priority(_actor) > highest_priority.priority(_actor)):
			highest_priority = goal

	return highest_priority


#
# Executes plan. This function is called on every game loop.
# "plan" is the current list of actions, and delta is the time since last loop.
#
# Every action exposes a function called perform, which will return true when
# the job is complete, so the agent can jump to the next action in the list.
#
func _follow_plan(plan, delta):
	if plan.size() == 0:
		return

	var is_step_complete = await plan[_current_plan_step].perform(_actor, delta)
	if is_step_complete and _current_plan_step < plan.size() - 1:
		_current_plan_step += 1
