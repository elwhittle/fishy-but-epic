extends Area2D

class_name Fish

# Declare member variables here
var start_scale
var max_scale
var growth_points

var move_speed
var color_sat = 0.2

var v_size      # viewport size
var total_pixels
var pixels_wide

# Called when the node enters the scene tree for the first time.
func _ready():
	v_size = get_viewport().size
	$AnimatedSprite.playing = true

func update_size():
	#print(growth_points)
	if scale.x > 0:
		scale = growth_to_scale() * Vector2.ONE
	else:
		scale = growth_to_scale() * Vector2(-1, 1)
	$AnimatedSprite.set_modulate(Color.from_hsv((abs(scale.x-start_scale)) / max_scale, color_sat, 1.0))

func growth_to_scale():
	return pow(growth_points / total_pixels, 0.5)

func scale_to_growth(target_scale):
	return pow(target_scale, 2) * total_pixels
