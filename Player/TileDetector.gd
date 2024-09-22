extends Area2D

signal map_exit_was_hit(exit_number: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _process_tilemap_collision(body: Node2D, body_rid: RID):
	var current_tilemap = body
	#return 0
	var _collided_tile_coords = current_tilemap.get_coords_for_body_rid(body_rid)
			
	var tile_data = current_tilemap.get_cell_tile_data(_collided_tile_coords)
	var exit = tile_data.get_custom_data("Exit")
	print(exit)
	print("Time left: " + str($CollisionCooldownTimer.get_time_left()))
	if exit == null:
		exit = 0
	if exit != 0 and $CollisionCooldownTimer.get_time_left() == 0:
		map_exit_was_hit.emit(exit)
		start_collision_timer()
	return exit
		
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		_process_tilemap_collision(body, body_rid)

func start_collision_timer():
		$CollisionCooldownTimer.set_wait_time(0.1)
		$CollisionCooldownTimer.set_one_shot(true)
		$CollisionCooldownTimer.start()
