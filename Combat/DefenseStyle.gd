extends Resource
class_name DefenseStyle

@export var icon : Texture
@export var style_name : String

@export var protects_against : Array[DamageType]
@export var reduction_percent : float = .5

func modify_attack(attack : Attack, stats : CharacterStats):
	if protects_against.has(attack.damage_type):
		attack.damage_amount -= stats.get_stat(attack.damage_type.defense_to_compare).value
		attack.damage_amount *= reduction_percent
	return attack

