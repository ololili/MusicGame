extends TextureProgressBar


func _ready():
	Globals.received_damage.connect(_on_globals_received_damage)

func _on_globals_received_damage(amount: float):
	value += amount
	if value > 100:
		value = 100.0
	elif value < 0:
		value = 0.0
