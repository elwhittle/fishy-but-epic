extends Fish

var move_right

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time. ( Y )
func _ready():
	total_pixels = 981.0
	pixels_wide = 58
	max_scale = 3.0
	rng.randomize()
	move_right = rng.randi_range(0, 1)
	start_scale = 0
	
	# set size
	#set_size(rng.randf_range(0.05, max_scale), rng.randf_range(0, 1))
	growth_points = scale_to_growth(rng.randf_range(0.05, max_scale))
	update_size()
	
	# set side of screen based on movement direction
	if move_right:
		position.x = -pixels_wide/2
	else:
		position.x = v_size.x+pixels_wide/2
	position.y = rng.randf_range(0, v_size.y) 	# set height too

	# set speed
	move_speed = 60 * rng.randi_range(1, 4)
	
	if move_right:
		scale.x *= -1


func _physics_process(_delta):
	# move the direction you're facing, Fish.
	if move_right:
		position.x += move_speed * _delta
	else:
		position.x -= move_speed * _delta
	
	#$AnimatedSprite.set_modulate(Color.from_hsv(position.x / max_scale, .6, 1.0))
	
	# despawn when off screen
	if (move_right and position.x > v_size.x + pixels_wide * abs(scale.x)) \
	or (!move_right and position.x < -pixels_wide * scale.x):
		queue_free()
