extends Area2D

class_name Fish

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var v_size      # viewport size
var _scale      # fish size
var move_speed
var pixels_wide

# Called when the node enters the scene tree for the first time.
func _ready():
	v_size = get_viewport().size
	move_speed = 200
	_scale = 1 # for now we just have big fish
	var hitbox = $CollisionShape2D
	pixels_wide = hitbox.shape.extents.x * _scale
	$AnimatedSprite.playing = true

