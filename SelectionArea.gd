extends Area2D
class_name SelectArea

signal selection_toggled(selection)
signal hovered_changed(state)

@export var exclusive = true
var hovered = false
var selected = false 



func _input(event):
	if event.is_action_pressed("MouseTarget"):
		if hovered:
			set_select(!selected)

func make_exclusive():
	if exclusive:
		get_tree().call_group("selected","set_select",false)

func set_select(selection : bool):
	if selection:
		if exclusive:
			make_exclusive()
		add_to_group("selected")
	else:
		remove_from_group("selected")
	selected = selection
	selection_toggled.emit(selection)

func _on_mouse_entered():
	hovered = true
	hovered_changed.emit(hovered)


func _on_mouse_exited():
	hovered = false
	hovered_changed.emit(hovered)
