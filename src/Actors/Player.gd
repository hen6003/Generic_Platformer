extends KinematicBody2D

export var gravity: = 3000.0
var _velocity: = Vector2.ZERO
export var end_of_level = 2000.0
export var next_scene: PackedScene
export var start_position: = Vector2(230.0, 830) 
var direction = Vector2(0.0, 0.0)

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	kill_player()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	position = start_position

func _physics_process(delta: float) -> void:
	var speed = globals.speed

	if Input.is_action_just_pressed("exit"):
		anim_player.play("exit")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		yield(anim_player, "animation_finished")
		get_tree().change_scene("res://src/Levels/LevelTitle.tscn")

	if not get_tree().get_current_scene().get_name() == "DeathScreen" or get_tree().get_current_scene().get_name() == "Title_Screen":
		globals.last_level = get_tree().get_current_scene().get_name()

	if get_position().y > 1200.0:
		kill_player()

	if get_position().x > end_of_level:
		anim_player.play("win")
		globals.time = globals.time - 1
		yield(anim_player, "animation_finished")
		get_tree().change_scene_to(next_scene)

	var is_jump_interrupted: = Input.is_action_just_released("move_up") and _velocity.y < 0.0

	direction = get_direction()

	_velocity = get_move_velocity(_velocity, speed, direction, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(
		1.0 if Input.is_action_pressed("move_right") else -1.0 if Input.is_action_pressed("move_left") else 0.0,
		-1.0 if Input.is_action_pressed("move_up") and is_on_floor() else 1.0
	)

func get_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()

	if direction.y == -1.0:
		out.y = speed.y * direction.y

	if is_jump_interrupted:
		out.y = 0.1

	_velocity.y = min(_velocity.y, speed.y)

	return out

func kill_player():
	anim_player.play("death")
	yield(anim_player, "animation_finished")
	position = start_position
