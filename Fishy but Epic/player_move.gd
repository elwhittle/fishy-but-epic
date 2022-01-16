extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move_speed = 300
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	velocity.x += Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y += Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized() * move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# move the player
	get_input()
	move_and_slide(velocity)
