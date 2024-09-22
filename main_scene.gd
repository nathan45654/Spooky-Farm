extends Node

signal camera_limits_changed(map_limits: Rect2i)

func _ready() -> void:
	#$MapsManager.camera = $player/Camera2D
	$player/TileDetector.connect("map_exit_was_hit", $MapsManager.on_map_exit_was_hit)

func _process(_delta):
	$player/Camera2D.align()
	


func _on_maps_manager_get_camera() -> void:
	$MapsManager.camera = $player/Camera2D
