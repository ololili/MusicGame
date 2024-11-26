extends Area2D


@export var power: Power = null
@export var speed: float = 10
var is_moving: bool = false


func _ready():
	$MyAnimationPlayer.play("startup")
	Globals.has_beaten.connect(start)

func _process(delta):
	if is_moving:
		position.x -= speed * delta


func start():
	is_moving = true
