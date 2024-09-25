extends "res://Maps/Map.gd"

var crops

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crops = [$CropManager/Zucchini]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func update_crops():
	#for crop in crops:
		#crop.daily_growth()
