extends Node

signal update_inventory_ui(location_index: int, texture: Texture)

@onready var ZucchiniSeed = preload("res://Player/Inventory Items/Inventory Seeds/zucchini_seed.tscn")

@onready var inventory_container

@onready var crops = {"1": "", "2": "", 
	"3": "", "4": "", 
	"5": "", "6": "",
	"7": "", "8": "",
	"9": "", "10": ""}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#add_child(crops["1"])
	

func initialize():
	#pass
	
	add_to_inventory(ZucchiniSeed.instantiate(), 1)
	add_to_inventory(ZucchiniSeed.instantiate(), 2)
	add_to_inventory(ZucchiniSeed.instantiate(), 3)
	add_to_inventory(ZucchiniSeed.instantiate(), 4)
	add_to_inventory(ZucchiniSeed.instantiate(), 5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_to_inventory(inventory_item: Node, location_index: int):
	crops[str(location_index)] = inventory_item
	add_child(inventory_item)
	inventory_item.get_node("TextureRect").hide()
	
	var item_texture = inventory_item.get_node("TextureRect").texture
	inventory_container.update_inventory_ui(item_texture, location_index)
	
	
func remove_from_inventory(inventory_item: Node, location_index: int):
	crops[str(location_index)] = ""
	remove_child(inventory_item)
	inventory_container.update_inventory_ui(null, location_index)
