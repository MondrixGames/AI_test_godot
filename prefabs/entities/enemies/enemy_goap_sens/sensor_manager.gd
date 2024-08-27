extends Node3D

@onready var enemy_goap_sens: CharacterBody3D = $".."
@onready var check_raycast: RayCast3D = $CheckRaycast
@onready var far_sight_sensor: Area3D = $FarSightSensor
var sight_memory : Dictionary = {}
var player_pos: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_far_sight_timer_timeout() -> void:
	var overlaps = far_sight_sensor.get_overlapping_areas()
	if overlaps.size() > 0:
		for overl in overlaps:
			if overl.get_parent().is_in_group("player"):
				check_raycast.look_at(overl.global_transform.origin, Vector3.UP)
				var collider = check_raycast.get_collider()
				if collider is Area3D and collider.get_parent().is_in_group("player"):
					print_rich("[color=green][b]Player_pos:[/b][/color]")
					print(overl.global_transform.origin)
					player_pos = overl.global_transform.origin
					


#func _on_far_sight_sensor_area_entered(area: Area3D) -> void:
	#if area.is_in_group("cover"):
		#var parent_node = area.get_parent()
		#var cover_id = parent_node.name
		#check_raycast.look_at(parent_node.global_transform.origin, Vector3.UP)
		#if !check_raycast.is_colliding():
			#sight_memory[cover_id] = parent_node.global_position
			#print(sight_memory)
