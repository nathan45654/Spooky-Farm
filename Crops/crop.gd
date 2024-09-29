#class_name Crop
extends Node2D

var unripe_day
var harvestable_day
var is_harvestable = false
var total_days_passed
var crop_name = "Zucchini"

func _ready() -> void:
	$AnimatedSprite2D.animation = "seed"
	total_days_passed = 0
	#$player
	unripe_day = 2
	harvestable_day = 4

func _process(delta: float) -> void:
	pass
	
func daily_growth():
	
	total_days_passed += 1
	
	if total_days_passed == 0:
		$AnimatedSprite2D.animation = "seed"
	elif 0 < total_days_passed and total_days_passed < unripe_day:
		$AnimatedSprite2D.animation = "sprout"
	elif unripe_day <= total_days_passed and total_days_passed < harvestable_day:
		$AnimatedSprite2D.animation = "unripe"
	elif total_days_passed >= harvestable_day:
		$AnimatedSprite2D.animation = "harvestable"
		is_harvestable = true
