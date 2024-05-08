class_name Attack

var damage_type : AttackStyle
var damage_stat : CharacterStats.StatType
var damage_amount : float

func _init(style : AttackStyle, stats : CharacterStats):
	damage_type = style
	damage_amount = stats.get_stat(damage_type.stat_to_scale_with).value
