extends Control

onready var lab = get_node("Label")

func _ready() -> void:
	timer()

func timer():
	while true:
		if not globals.last_level == "LevelEnd":
			globals.time = globals.time + 1

		lab.set_text(str(globals.time) + "s")
		yield(get_tree().create_timer(1.0), "timeout")