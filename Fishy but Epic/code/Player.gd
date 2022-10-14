extends Fish


# member variables
var velocity = Vector2()
var drag = .015
var acceleration = .03

var munch_sound = preload("res://assets/ticket-muncher.wav")
enum {SOUND_MUNCH}

func _ready():
	move_speed = 350
	start_scale = 2
	max_scale = 20
	total_pixels = 62
	pixels_wide = 13
	growth_points = scale_to_growth(start_scale)
	
	update_size()

func get_input():
	var inputVec = Vector2()
	inputVec.x += Input.get_action_strength("right") - Input.get_action_strength("left")
	inputVec.y += Input.get_action_strength("down") - Input.get_action_strength("up")
	if inputVec.length() == 0:
		$AnimatedSprite.animation = "rest"
	else:
		$AnimatedSprite.animation = "swim"
		if inputVec.x != 0:
			if inputVec.x > 0:
				scale.x = -abs(scale.x)
			else:
				scale.x = abs(scale.x)
	
	velocity -= velocity * drag
	velocity += inputVec * move_speed * acceleration
	
	if abs(velocity.x) < 5:
		velocity.x = 0
	if abs(velocity.y) < 5:
		velocity.y = 0
	
	velocity = velocity.limit_length(move_speed)
	#var speed = velocity.length()
	#velocity = velocity.normalized() * speed

func keep_in_bounds():
	# keep player within y bounds
	if position.y < 0:
		position.y = 0
	elif position.y > v_size.y: 
		position.y = v_size.y
	# screen wraps left-to-right
	if position.x < 0:
		position.x = v_size.x
	elif position.x > v_size.x:
		position.x = 0

func _physics_process(delta):
	# move the player
	get_input()
	position = position + velocity * delta
	keep_in_bounds()

func eat(meal):
	var growth = meal.growth_points * .25
	meal.queue_free() # meal dies
	growth_points += growth
	update_size()
	$Muncher.play()

func _on_Player_area_entered(area):
	if growth_points >= area.growth_points:
		# eat the small guy O< o
		eat(area)
		return
	else:
		die()

func die():	
	print("dead")
	$Muncher.play()
	get_tree().change_scene("res://scenes/main.tscn")
	
