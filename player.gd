extends CharacterBody2D

signal hit

@export var speed = 100
#var screen_size
var status = "idle"

func _ready() -> void:
	pass
	#$TileDetector.map_exit_was_hit.connect(parent().map_exit_was_hit)

func _process(delta: float) -> void:
	
	status = "idle"
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.animation = "attack"
		status = "attack"
		velocity = Vector2.ZERO
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"
		
	move_and_slide()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
		
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)

	


func _on_tile_detector_map_exit_was_hit(exit_number: int) -> void:
	pass # Replace with function body.
