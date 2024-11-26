extends Resource

class_name Power


var level_dict: Dictionary = {5: "max", 4: "hi", 3: "mid", 2: "lo", 1: "min", 0: "no"}
var level: int = 5
var level_number = 5

func _init():
	level = 5

func get_level_name() -> String:
	return level_dict[level]
