extends Resource
class_name EnemyData

@export var potential_damage_types : Array[AttackStyle]
@export var potential_defense_styles : Array[DefenseStyle]

@export var enemy_stats : CharacterStats
@export var sprite : Texture


func choose_damage_type() -> AttackStyle:
	return potential_damage_types.pick_random()
func chose_defense_style() -> DefenseStyle:
	return potential_defense_styles.pick_random()
