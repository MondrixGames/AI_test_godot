extends CharacterBody3D

#region @onready Variables:
@onready var camera: Camera3D = $head/PlayerCamera
@onready var head: Node3D = $head

#endregion

#region @export Variables:
@export_group("Movement")
@export var walking_speed: float = 5.0
@export var sprinting_speed: float = 8.0
@export var jump_velocity: float = 4.5
#endregion

#region Input Variables
@export_group("Input Sensitivity")
@export var mouse_sensitivity = 0.4
@export var zoom_sensitivity = 0.5
#endregion

#region Private Variables
var direction = Vector3.ZERO
var current_speed = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#endregion

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	WorldState.set_state("playerIsAlive", true)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	if event.is_action_pressed("shoot"):
		WorldState.set_state("isThreatened", true)
	if event.is_action_pressed("revive"):
		WorldState.set_state("playerIsAlive", true)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_pressed("sprint"):
		current_speed = sprinting_speed
	else:
		current_speed = walking_speed

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 15.0)
			velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 15.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 3.0)
	move_and_slide()
