extends Node2D

var cave = preload("res://assets/cave.png")
var rain = preload("res://assets/rain.png")
var sky = preload("res://assets/sky.png")

onready var anim_player: AnimationPlayer = get_node("CanvasLayer/AnimationPlayer")
onready var background = get_node("CanvasLayer/background")
onready var mute = get_node("CanvasLayer/CheckButton")

func _ready() -> void:
	background_changer()

	if globals.music_player.is_playing():
		mute.pressed = false

	else:
		mute.pressed = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

	if Input.is_action_just_pressed("play"):
		play()

	if Input.is_action_just_pressed("mute"):
		if globals.music_player.is_playing():
			mute.pressed = true
			globals.music_player.stop()

		else:
			mute.pressed = false
			globals.music_player.play()

func background_changer() -> void:
	while true:
		yield(get_tree().create_timer(60.0), "timeout")
		anim_player.play("switch_back")
		background.set_texture(rain)
		yield(get_tree().create_timer(60.0), "timeout")
		anim_player.play("switch_back")
		background.set_texture(sky)
		yield(get_tree().create_timer(60.0), "timeout")
		anim_player.play("switch_back")
		background.set_texture(cave)

func play() -> void:
	anim_player.play("play")
	globals.speed = Vector2(600.0, 1200.0)
	globals.time = 0
	globals.time = globals.time - 1
	yield(anim_player, "animation_finished")
	get_tree().change_scene("res://src/Levels/Level0.tscn")

func _on_Play_pressed() -> void:
	play()

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_LinkButton_pressed() -> void:
	OS.shell_open("https://hen6003.github.io")

func _on_CheckButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		globals.music_player.stop()

	else:
		globals.music_player.play()
