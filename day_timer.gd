extends Timer

var game_hours
var game_minutes
var wake_up_time
var seconds_in_a_day
var bed_time
var seconds_to_game_time_hours

func _ready() -> void:
	autostart = true
	
	wake_up_time = 6.5 # in game hours
	bed_time = 3 # in game hours
	var real_seconds_to_game_seconds = 0.1
	
	seconds_in_a_day = (24 + wake_up_time - bed_time) * real_seconds_to_game_seconds
	#seconds_in_a_day = (bed_time - wake_up_time) * 60
	seconds_to_game_time_hours = (24 - (wake_up_time - bed_time)) / seconds_in_a_day
	
	start_day()
	
func _process(delta: float) -> void:
	get_game_time()

func get_game_time():
	var time_left = get_time_left()
	var game_time = (seconds_in_a_day - time_left) * seconds_to_game_time_hours
	game_minutes = int( (game_time + wake_up_time - int(game_time + wake_up_time)) * 60 )
	game_hours = int(game_time) + int(wake_up_time)
	
	#print(time_left)
	if game_minutes < 10:
		print(str(game_hours) + ":0" + str(game_minutes))
	else:
		print(str(game_hours) + ":" + str(game_minutes))
	

func start_day():
	start(seconds_in_a_day)
