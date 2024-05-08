extends CheckButton


func _on_toggled(toggled_on):
	$"../Stats".visible = toggled_on
