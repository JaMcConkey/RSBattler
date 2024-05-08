extends Node
class_name Player

@export var equipped_helmet : EquipItem
@export var equipped_chest : EquipItem
@export var equipped_legs : EquipItem
@export var equipped_gloves : EquipItem
@export var equipped_boots : EquipItem
@export var equipped_main_hand : Weapon
@export var equipped_off_hand : Weapon

func try_equip(item_to_equip : EquipItem) -> bool:
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
