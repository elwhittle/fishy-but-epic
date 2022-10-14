extends Node

var rng = RandomNumberGenerator.new()
var spawn_chance
var base = 1.0
#var base = 1000000.0

func _ready():
	rng.randomize()
	spawn_chance = base

func _physics_process(delta):
	if (rng.randf() < spawn_chance*delta):
		spawn_chance = base
		var s = load("res://prefabs/Fish.tscn")
		var fish = s.instance()	
		add_child(fish)
	else:
		spawn_chance += delta
