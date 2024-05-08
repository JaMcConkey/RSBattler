extends Resource
class_name StatModifier

@export var stat : CharacterStats.StatType
@export var add_amount : float
@export var multiplier : float

var source

func set_source(source_to_set):
	source = source_to_set
