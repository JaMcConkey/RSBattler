extends Resource
class_name ItemData

@export var item_name : String
@export_multiline var item_description : String
@export var item_type : SlotFlags
@export var texture : Texture

enum SlotFlags{
	ANY,
	CONSUME,
	HELM,
	CHEST,
	LEGS,
	GLOVES,
	BOOTS,
	MAINHAND,
	OFFHAND
}
#enum SlotFlags {
	#ANY = 1 << 0,
	#CONSUMABLE = 1 << 1,
	#E_HELM  = 1 << 16,
	#E_CHEST = 1 << 17,
	#E_LEGS = 1 << 18,
	#E_BOOTS = 1 << 19,
	#E_GLOVES = 1 << 20,
	#E_WEAPON = 1 << 21,
#} 

func on_interact() -> void:
	pass
func use_item() -> void:
	pass
