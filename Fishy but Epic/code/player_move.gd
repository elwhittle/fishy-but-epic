extends Fish


# member variables
var velocity = Vector2()

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
	velocity = velocity.normalized() * speed

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

func _physics_process(_delta):
	# move the player
	get_input()
	position = position + velocity*_delta
	keep_in_bounds()

func _on_Player_area_entered(area):
	if scale >= area.scale:
		# eat the small guy
		return
	else:
		die()

func die():
	print("dead")
