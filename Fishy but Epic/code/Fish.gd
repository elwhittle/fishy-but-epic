extends Area2D

class_name Fish

# Declare member variables here
var start_scale
var max_scale
var fish_scale      # variable fish size

var move_speed

var v_size      # viewport size
var pixels_wide

# Called when the node enters the scene tree for the first time.
func _ready():
	v_size = get_viewport().size
	$AnimatedSprite.playing = true

func set_size(new_size, sat = 0.2):
	fish_scale = new_size
	scale = fish_scale * Vector2.ONE
	pixels_wide = $CollisionShape2D.shape.extents.x * fish_scale
	$AnimatedSprite.set_modulate(Color.from_hsv((abs(fish_scale-start_scale)) / max_scale, sat, 1.0))
