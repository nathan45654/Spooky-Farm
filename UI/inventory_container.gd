extends GridContainer

@onready var inventory_ui_dict = {"1": null,
	"2": null,
	"3": null,
	"4": null,
	"5": null
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in inventory_ui_dict:
		var panel = Panel.new()
		panel.theme = theme
		panel.set_custom_minimum_size(Vector2(64, 64))
		add_child(panel)
		var new_rect = TextureRect.new()
		new_rect.set_custom_minimum_size(Vector2(64, 64))
		panel.add_child(new_rect)
		inventory_ui_dict[item] = new_rect

func _process(delta: float) -> void:
	pass

func update_inventory_ui(texture: Texture, inventory_index: int) -> void:
	var texture_rect = inventory_ui_dict[str(inventory_index)]
	texture_rect.texture = texture
	texture_rect.show()
	
