extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func _on_day_timer_set_clock_text(clock_string: String) -> void:
	$ClockPanel/Clock.set_text(clock_string)
