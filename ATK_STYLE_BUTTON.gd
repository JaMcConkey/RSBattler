extends Control

var style : AttackStyle
@onready var button = $Button


func init_button(damage_type : AttackStyle):
	style = damage_type
	button.icon = damage_type.icon
	button.text = damage_type.style_name


