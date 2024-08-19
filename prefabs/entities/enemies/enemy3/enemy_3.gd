extends CharacterBody3D

var movement_target_position: Vector3
@export var movement_speed: float = 2.0
@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
  # Here is where I define which goals are available for this
  # npc. In this implementation, goals priority are calculated
  # dynamically. Depending on your use case you might want to
  # have a way to define different goal priorities depending on
  # npc.
	var agent = GoapAgent.new()
	agent.init(self, [
		PlayerIsDeadGoal.new(),
		StaySafeGoal.new(),
		RelaxGoal.new()
	])
	
	add_child(agent)
	
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func kill_player():
	body_mesh.get_active_material(0).albedo_color = "ff58ff"
	return true

func is_chill():
	body_mesh.get_active_material(0).albedo_color = "ff5600"
	return true

func move_to(target_position, delta):
	set_movement_target(target_position)
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed * delta * 100
	print(delta)
	move_and_slide()