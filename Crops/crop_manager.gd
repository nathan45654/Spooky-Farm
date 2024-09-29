extends Node

@onready var Zucchini = preload("res://Crops/Zucchini.tscn")
var crops = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_crop_dictionary()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#for crop in crops:
		#print("here")

func plant_crop(crop_coord: Vector2i, crop: Node2D):
	var crop_tile_status = get_crop_tile_status(crop_coord)
	if crop_tile_status == 0:
		pass
	elif crop_tile_status == 1:
		var zucchini = Zucchini.instantiate()
		zucchini.set_position(crop_coord*32)
		zucchini.show()
		$AllCrops.add_child(zucchini)
		crops[crop_coord] = 2
		print("new zucchini")
	elif crop_tile_status == 2:
		pass
		
func harvest_crop(crop_coord: Vector2i) -> String:
	var crop_to_harvest = "None"

	var crop_tile_status = get_crop_tile_status(crop_coord)
	#if crop_tile_status == 2:
	var all_crops = $AllCrops.get_children()
	for index in all_crops.size():
		var crop = all_crops[index]
		if crop_coord == Vector2i(crop.position/32):
			if crop.is_harvestable:
				crop_to_harvest = crop.crop_name
				
				all_crops.remove_at(index)
				crop.queue_free()
				set_crop_tile_status(crop_coord, 1)
				print(crops[crop_coord])

	return crop_to_harvest
				
			
func get_crop_tile_status(crop_coord: Vector2i):
	return crops[crop_coord]
	
func set_crop_tile_status(crop_coord: Vector2i, new_status: int):
	crops[crop_coord] = new_status
	
func update_crops():
	var crops = $AllCrops.get_children()
	for crop in crops:
		crop.daily_growth()

func generate_crop_dictionary():
	var all_farm_cells = $crops.get_used_cells()
	for cell in all_farm_cells:
		var crop_tile_data = $crops.get_cell_tile_data(cell)
		var crop_tile_status = crop_tile_data.get_custom_data("CropStatus")
		crops[cell] = crop_tile_status
