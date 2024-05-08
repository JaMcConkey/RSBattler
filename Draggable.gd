extends Control

var dragging = false
var offset : Vector2
@export var control_to_move : Control
@export var click_rect : Control

func _on_gui_input(event):
		if event is InputEventMouseButton:
			print("IS MOUSE EVENT")
			if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
				# Check if mouse is pressed within the Control node
				print("EVENT ON")
				if click_rect.get_global_rect().has_point(get_global_mouse_position()):
					dragging = true
					offset = get_global_mouse_position() - control_to_move.global_position
					# Calculate offset from mouse position to the top-left corner of the Control node
					print("SHOULD BE DRAGGING HERE")
					return true
			elif event.button_index == MOUSE_BUTTON_LEFT and dragging and not event.pressed:
				# Stop dragging when the left mouse button is released
				dragging = false
				return true
		elif event is InputEventMouseMotion and dragging:
			# Move the Control node based on mouse movement
			control_to_move.global_position = get_global_mouse_position() - offset
			return true
