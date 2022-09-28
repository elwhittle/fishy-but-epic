extends Node

var rng = RandomNumberGenerator.new()
var spawn_chance

func _ready():
	rng.randomize()
	spawn_chance = 0.1

func _physics_process(delta):
	if (rng.randf() < spawn_chance*delta):
		spawn_chance = 0.1
		var s = load("res://prefabs/Fish.tscn")
		var fish = s.instance()	
		add_child(fish)
	else:
		spawn_chance += delta/2
