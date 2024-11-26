extends Resource

class_name Power


var level_dict: Dictionary = {5: "max", 4: "hi", 3: "mid", 2: "lo", 1: "min", 0: "no"}
var level: float = 1.0
var level_number = 5

func _init():
	set_level(1.0)

func get_level_name() -> String:
	return level_dict[level_number]

func set_level(new_level: float):
	level = 0.0
	change_level(new_level)

func change_level(change: float):
	level += change
	if level > 1:
		level = 1.0
	elif level < 0:
		level = 0.0
	set_level_number()

func set_level_number():
	if level == 1.0:
		level_number = 5
		return true
	if level == 0.0:
		level_number = 0
		return true
	var num = level * 4 + 1
	level_number = int(num)
