extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move_speed = 300
var velocity = Vector2()

var size

# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_viewport().size
	$AnimatedSprite.playing = true

func get_input():
	velocity = Vector2()
	velocity.x += Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y += Input.get_action_strength("down") - Input.get_action_strength("up")
	if velocity.length() == 0:
		$AnimatedSprite.animation = "rest"
	else:
		$AnimatedSprite.animation = "swim"
		if velocity.x != 0:
			$AnimatedSprite.flip_h = velocity.x > 0
	velocity = velocity.normalized() * move_speed

func keep_in_bounds():
	# keep player within y bounds
	if position.y < 0:
		position.y = 0
	elif position.y > size.y: 
		position.y = size.y
	# screen wraps left-to-right
	if position.x < 0:
		position.x = size.x
	elif position.x > size.x:
		position.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# move the player
	get_input()
	move_and_slide(velocity)
	keep_in_bounds()
	
	
