extends Node

var Home_exits = {}
var Farm_exits = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Home_exits_mapping()
	Farm_exits_mapping()

func Home_exits_mapping():
	Home_exits = {"2": ^"Farm", "3": ^"Cemetery"}
	#var Home_Cemetery = 3
	
func Farm_exits_mapping():
	Farm_exits = {"2": "Home"}
