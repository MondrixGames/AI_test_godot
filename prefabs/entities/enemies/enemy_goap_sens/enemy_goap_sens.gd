extends CharacterBody3D

var movement_target_position: Vector3
@export var movement_speed: float = 2.0
@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var weapon_ray_cast: RayCast3D = $WeaponRayCast
@onready var name_tag: Label3D = $NameTag
@onready var goal_tag: Label3D = $GoalTag


var _state = {}

func get_state(state_name, default = null):
	return _state.get(state_name, default)

func set_state(state_name, value):
	_state[state_name] = value

func clear_state():
	_state = {}


func _ready():
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
  # Here is where I define which goals are available for this
  # npc. In this implementation, goals priority are calculated
  # dynamically. Depending on your use case you might want to
  # have a way to define different goal priorities depending on
  # npc.
	var agent = GoapAgent.new()
	agent.init(self, [
		PlayerIsDeadGoal.new(),
		StaySafeGoal.new(),
		RelaxGoal.new(),
		#GrabWeaponGoal.new(),
	], 0.1)
	
	add_child(agent)
	
	call_deferred("actor_setup")
	
	name_tag.text = self.name

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func grab_weapon(weapon) -> bool:
	weapon.grabbed()
	return true

func shoot_player(player) -> bool:
	look_at(player.position)
	if weapon_ray_cast.is_colliding():
		var collider = weapon_ray_cast.get_collider()
		if collider.is_in_group("player"):
			var material_instance = body_mesh.get_active_material(0).duplicate()
			body_mesh.set_surface_override_material(0, material_instance)
			# Change the color of the material for this specific node
			material_instance.albedo_color = Color("ff58ff")
			return true
	return false

func kill_player() -> bool:
	# Ensure the node has its own unique material instance
	var material_instance = body_mesh.get_active_material(0).duplicate()
	body_mesh.set_surface_override_material(0, material_instance)
	# Change the color of the material for this specific node
	material_instance.albedo_color = Color("ff58ff")
	return true


func is_chill(cover) -> bool:
	# Remove the node from the "cover" group
	cover.remove_from_group("cover")

	# Ensure the node has its own unique material instance
	var material_instance = body_mesh.get_active_material(0).duplicate()
	body_mesh.set_surface_override_material(0, material_instance)

	# Change the color of the material for this specific node
	material_instance.albedo_color = Color("ff5600")
	return true


func move_to(target_position, _delta):
	set_movement_target(target_position)
	if navigation_agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		return
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()
