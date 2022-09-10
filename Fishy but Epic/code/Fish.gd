extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var v_size      # viewport size
var _scale		# fish size
var move_right
var speed
var pixels_wide

# Called when the node enters the scene tree for the first time.
func _ready():
	v_size = get_viewport().size
	move_right = true
	speed = 50
	_scale = 1 # for now we just have big fish
	var hitbox = $CollisionShape2D
	pixels_wide = hitbox.shape.extents.x * _scale
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	# move the direction you're facing, Fish
	if move_right:
		position.x += speed * delta
	else:
		position.x -= speed * delta
	
	# despawn when off screen
	if (move_right and position.x > v_size.x + pixels_wide) \
	or (!move_right and position.x < -pixels_wide):
		queue_free()
