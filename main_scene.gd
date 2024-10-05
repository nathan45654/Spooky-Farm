extends Node

### TO_DO
# create inventory item scene
# create UI for inventory and way to access inventory items in inventory
# create crop seeds inventory item

var total_days

func _ready() -> void:
	total_days = 0
	$player/TileDetector.connect("map_exit_was_hit", $MapsManager.on_map_exit_was_hit)
	$DayTimer.start_day()
	var crop_manager = $MapsManager/Farm/CropManager
	$player.crop_manager = crop_manager
	$player/Inventory.inventory_container = $UI/InventoryContainer
	$player.initialize()
	
	
func _process(_delta):
	$player/Camera2D.align()
	$UI.set_position($player/Camera2D.get_screen_center_position())

func _on_maps_manager_get_camera() -> void:
	$MapsManager.camera = $player/Camera2D

func _on_day_timer_timeout() -> void:
	total_days += 1
	$MapsManager/Farm/CropManager.update_crops()
	
