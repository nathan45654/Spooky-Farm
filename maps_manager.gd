extends Node

signal get_camera()
signal set_player_position(new_position: Vector2)
var current_map
var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Farm.enable_maps(true)
	$Home.enable_maps(false) # Replace with function body.
	$Church.enable_maps(false)
	
	get_camera.emit()
	current_map = $Farm
	set_camera_limits(current_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func switch_maps(incoming_map:NodePath, exit_number: int):
	var incoming_map_node = get_node(incoming_map)
	var incoming_map_exits = incoming_map_node.find_child("Exits")
	var exit_node = incoming_map_exits.find_child( str(exit_number) )

	var new_player_position = exit_node.get_position() + incoming_map_node.get_position()
	set_player_position.emit(new_player_position)
	set_camera_limits(incoming_map_node)
	current_map.enable_maps(false)
	incoming_map_node.enable_maps(true)
	current_map = incoming_map_node

func on_map_exit_was_hit(exit_number: int):
	
	var incoming_map
	if current_map == $Home:
		incoming_map = $MapsInfo.Home_exits[str(exit_number)]
	if current_map == $Farm:
		incoming_map = $MapsInfo.Farm_exits[str(exit_number)]
	if current_map == $Church:
		incoming_map = $MapsInfo.Church_exits[str(exit_number)]
		
	switch_maps(incoming_map, exit_number)
	
	print("hit " + str(exit_number))

func set_camera_limits(incoming_map_Node: Node):
	var incoming_map_layer = incoming_map_Node.find_child("Floor")
	var map_limits = incoming_map_layer.get_used_rect()
	
	#emit camera_limits_changed(map_limits)
	var map_cellsize = 32
	camera.limit_left = map_limits.position.x * map_cellsize + incoming_map_Node.get_position().x
	camera.limit_right = map_limits.end.x * map_cellsize + incoming_map_Node.get_position().x
	camera.limit_top = map_limits.position.y * map_cellsize + incoming_map_Node.get_position().y
	camera.limit_bottom = map_limits.end.y * map_cellsize + incoming_map_Node.get_position().y
