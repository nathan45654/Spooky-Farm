extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$boundary.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_maps(enable: bool) -> void:
	$Floor.enabled = enable
	$foreground.enabled = enable
	$objects.enabled = enable
	$boundary.enabled = enable
	
