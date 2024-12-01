class_name Power
extends Resource


var level_dict: Dictionary = {5: "max", 4: "hi", 3: "mid", 2: "lo", 1: "min", 0: "no"}
var level: int = 5
@export var fraction: float = 1.0


func set_fraction(new_fraction: float):
	fraction = new_fraction
	if fraction > 1:
		fraction = 1.0
	elif fraction < 0:
		fraction = 0.0
	update_level()

func change_fraction(change: float):
	set_fraction(fraction + change)


func update_level():
	if fraction == 1.0:
		level = 5
	elif fraction == 0.0:
		level = 0
	else:
		level = int(fraction * 4 + 1)

func get_level_name() -> String:
	return level_dict[level]
