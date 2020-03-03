extends Control

func _on_up_button_pressed() -> void:
	Input.action_press("move_up")

func _on_right_button_pressed() -> void:
	Input.action_press("move_right")

func _on_left_button_pressed() -> void:
	Input.action_press("move_left")

func _on_up_button_released() -> void:
	Input.action_release("move_up")

func _on_right_button_released() -> void:
	Input.action_release("move_right")

func _on_left_button_released() -> void:
	Input.action_release("move_left")