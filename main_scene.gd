extends Node

var current_map

func _ready() -> void:
	$Farm.enable_maps(false)
	$Home.enable_maps(true) # Replace with function body.
	current_map = $Home
	set_camera_limits(current_map)
	$player/TileDetector.connect("map_exit_was_hit", on_map_exit_was_hit)
	

	#switch_maps($Farm)
func _process(_delta):
	#$player/Camera2D.set_position($player.get_position())
	$player/Camera2D.align()
	
	

func switch_maps(incoming_map:NodePath, exit_number: int):
	var incoming_map_node = get_node(incoming_map)
	var incoming_map_exits = incoming_map_node.find_child("Exits")
	var exit_node = incoming_map_exits.find_child( str(exit_number) )

	$player.set_position( exit_node.get_position() + incoming_map_node.get_position())
	set_camera_limits(incoming_map_node)
	current_map.enable_maps(false)
	incoming_map_node.enable_maps(true)
	current_map = incoming_map_node

func set_camera_limits(incoming_map_Node: Node):
	var incoming_map_layer = incoming_map_Node.find_child("Floor")
	var map_limits = incoming_map_layer.get_used_rect()
	var map_cellsize = 32
	var camera = $player/Camera2D
	camera.limit_left = map_limits.position.x * map_cellsize + incoming_map_Node.get_position().x
	camera.limit_right = map_limits.end.x * map_cellsize + incoming_map_Node.get_position().x
	camera.limit_top = map_limits.position.y * map_cellsize + incoming_map_Node.get_position().y
	camera.limit_bottom = map_limits.end.y * map_cellsize + incoming_map_Node.get_position().y

func on_map_exit_was_hit(exit_number: int):
	
	var incoming_map
	if current_map == $Home:
		incoming_map = $MapsInfo.Home_exits[str(exit_number)]
	if current_map == $Farm:
		incoming_map = $MapsInfo.Farm_exits[str(exit_number)]
		
	switch_maps(incoming_map, exit_number)
	
	print("hit " + str(exit_number))
