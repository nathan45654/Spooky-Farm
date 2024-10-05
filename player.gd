extends CharacterBody2D

signal get_plant_tile(new_crop_coords: Node2D)

@onready var crop_manager

@export var speed = 100

var status = "idle"
var facing_direction = "down"
var input_direction = "down"

func _ready() -> void:
	pass

func initialize():
	$Inventory.initialize()

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
	if Input.is_action_pressed("select"):
		var placement_coords = get_placement_tile_coords()
		var crop_tile_status = crop_manager.get_crop_tile_status(placement_coords)
		var crop_to_harvest = null
		if crop_tile_status == 2:
			crop_to_harvest = crop_manager.harvest_crop(placement_coords)
			### add harvested crop to inventory here
			#crop_to_harvest.queue_free()
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

		var new_crop_position = get_placement_tile_coords()
		
		var crop_node = crop_manager.get_node("Zucchini")
		crop_manager.plant_crop(new_crop_position, crop_node)

func get_placement_tile_coords() -> Vector2i:
		var placement_direction = Vector2i(0,0)
		if facing_direction == "left": placement_direction.x = -1
		elif facing_direction == "right": placement_direction.x = 1
		elif facing_direction == "up": placement_direction.y = -1
		elif facing_direction == "down": placement_direction.y = 1
		
		# get crop position
		var player_position = position
		player_position.y += 16
		var placement_position = Vector2i(position)/32 + placement_direction
		
		return placement_position

func _on_maps_manager_set_player_position(new_position: Vector2) -> void:
	set_position(new_position)
