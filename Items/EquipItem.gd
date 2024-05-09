extends ItemData
class_name EquipItem

@export var test_stat_increase : Array[StatModifier]
@export var gain_def_styles : Array[DefenseStyle]
@export var equip_slot : EquipSlot

enum EquipSlot {
	MAIN_HAND,
	OFF_HAND,
	HELM,
	CHEST,
	LEGS,
	BOOTS,
	GLOVES
}

func use_item() -> void:
	pass
