extends Node

@onready var Zucchini = preload("res://Crops/Zucchini.tscn")
#var crops = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#for crop in crops:
		#print("here")

func plant_crop(crop_coord: Vector2i, crop: Node2D):
	var crops_node = get_node("crops")
	var crop_tile_data = crops_node.get_cell_tile_data(crop_coord)
	var crop_tile_status = crop_tile_data.get_custom_data("CropStatus")
	if crop_tile_status == 0:
		pass
	elif crop_tile_status == 1:
		var zucchini = Zucchini.instantiate()
		zucchini.set_position(crop_coord*32)
		#crops.append(zucchini)
		zucchini.show()
		$AllCrops.add_child(zucchini)
		crop_tile_data.set_custom_data("CropStatus", 2)
		print("new zucchini")
	elif crop_tile_status == 2:
		print("already has crop")
	
func update_crops():
	var crops = $AllCrops.get_children() # Replace with function body.
	for crop in crops:
		crop.daily_growth()
