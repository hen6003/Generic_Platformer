extends Control

onready var lab = get_node("Label")

func _ready() -> void:
	lab.set_text("High Score: " + str(globals.high_score + 59) + "s")