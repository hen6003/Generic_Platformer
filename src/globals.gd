extends Node

var last_level = "Level0"
var high_score = 940
var time = 0
var speed: = Vector2(600.0, 1200.0)
var music_player = AudioStreamPlayer.new()

func _ready():
	print("Generic Platformer\nMade By HEN6003")

	self.add_child(music_player)
	music_player.stream = load("res://assets/music.ogg")
	music_player.play()