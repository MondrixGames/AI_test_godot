extends Kinematic

var first_player: CharacterBody3D
var movement_target_position: Vector3
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		first_player = players[0]
