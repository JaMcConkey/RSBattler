class_name Attack

var damage_type : DamageType
var damage_stat : CharacterStats.StatType
var damage_amount : float
var attacker_stats : CharacterStats

func _init(style : DamageType, stats : CharacterStats):
	damage_type = style
	attacker_stats = stats
	damage_amount = attacker_stats.get_stat(damage_type.stat_to_scale_with).value
