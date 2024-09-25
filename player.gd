extends CharacterBody2D

signal hit
signal get_plant_tile(new_crop_coords: Node2D)

@onready var crop_manager

@export var speed = 100
#var screen_size
var status = "idle"
var facing_direction = "down"
var input_direction = "down"

func _ready() -> void:
	pass
	#$TileDetector.map_exit_was_hit.connect(parent().map_exit_was_hit)

func _process(delta: float) -> void:
	
	status = "idle"
	manage_input(delta)
	#position = position.clamp(Vector2.ZERO, screen_size)

func manage_input(delta: float):
	 
	# Facing Direction left to right
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		pass
	elif Input.is_action_pressed("left"):
		facing_direction = "left"
	elif Input.is_action_pressed("right"):
		facing_direction = "right"
	
	# Facing Direction up and down
	if Input.is_action_pressed("down") and Input.is_action_pressed("up"):
		pass
	elif Input.is_action_pressed("down"):
		facing_direction = "down"
	elif Input.is_action_pressed("up"):
		facing_direction = "up"
	
	#  Moving to new position
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	position += velocity * delta
	move_and_slide()

	# animations
	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.animation = "attack"
		status = "attack"
		velocity = Vector2.ZERO
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()

	# place an item (plant for now)
	if Input.is_action_just_pressed("place"):
		var new_crop_vector = Vector2i(0,0)
		if facing_direction == "left": new_crop_vector.x = -1
		elif facing_direction == "right": new_crop_vector.x = 1
		elif facing_direction == "up": new_crop_vector.y = -1
		elif facing_direction == "down": new_crop_vector.y = 1
		
		# get crop position
		var new_crop_position = Vector2i(position)/32 + new_crop_vector
		var crop_node = crop_manager.get_node("Zucchini")
		crop_manager.plant_crop(new_crop_position, crop_node)

		# do same as _process_tilemap_collision or similar to find the custom data of the tile
		# turn tile custom data in a planted tile, put crop on the tile
		# do something similar with harvesting. Same physics, if tile in front of you has the custom data 
		# that means something can be harvested, harvest and change custom data of the tile.

#func _on_tile_detector_map_exit_was_hit(exit_number: int) -> void:
	#pass # Replace with function body.

func _on_maps_manager_set_player_position(new_position: Vector2) -> void:
	set_position(new_position)
