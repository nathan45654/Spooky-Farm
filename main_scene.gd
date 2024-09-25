extends Node

signal camera_limits_changed(map_limits: Rect2i)

var total_days

func _ready() -> void:
	total_days = 0
	$player/TileDetector.connect("map_exit_was_hit", $MapsManager.on_map_exit_was_hit)
	$DayTimer.start_day()
	var crop_manager = $MapsManager/Farm/CropManager
	$player.crop_manager = crop_manager
func _process(_delta):
	$player/Camera2D.align()

func _on_maps_manager_get_camera() -> void:
	$MapsManager.camera = $player/Camera2D

func _on_day_timer_timeout() -> void:
	total_days += 1
	$MapsManager/Farm/CropManager.update_crops()
	
