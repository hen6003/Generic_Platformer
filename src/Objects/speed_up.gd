extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_speed_up_body_entered(body: PhysicsBody2D) -> void:
	anim_player.play("fade")
	globals.speed = globals.speed + Vector2(100.0, 0.0)
	yield(anim_player, "animation_finished")
	queue_free()
