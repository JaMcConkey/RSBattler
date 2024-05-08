extends Control
class_name EquipInventory

signal equip_updated

@onready var head_slot = $GearSlots/HeadSlot
@onready var chest_slot = $GearSlots/ChestSlot
@onready var leg_slot = $GearSlots/LegSlot
@onready var glove_slot = $GearSlots/GloveSlot
@onready var foot_slot = $GearSlots/FootSlot
@onready var main_hand_slot = $GearSlots/MainHandSlot
@onready var off_hand_slot = $GearSlots/OffHandSlot

var all_slots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $GearSlots.get_children():
		if child is InventorySlot:
			all_slots.append(child)
			child.init(Vector2(32,32),Vector2.ZERO)
			child.item_set.connect(_on_equip)
			child.item_removed.connect(_on_unequip)
			child.is_equip_slot = true
	PlayerManager.equip_inv = self
	pass # Replace with function body.

func update_equip_stats():
	pass

func _on_equip(item : InventoryItem):
	var itemm = item.data
	if itemm is EquipItem:
		for stat_mod in itemm.test_stat_increase:
			var test = PlayerManager.stats.get_stat(stat_mod.stat)
			test.add_modifier(stat_mod, item)
		for style in itemm.gain_atk_styles:
			print("ADD STYLE HERE")
			PlayerManager.add_damage_type(style)
			#var stat_to_mod = PlayerManager.stats.apply_modifier(stat_mod,item)
	else:
		print("WASNT EQUIP ITEM")
		return
	
	print("EQUIPPED : ", item.data.item_name)
func _on_unequip(item : InventoryItem):
	var itemm = item.data
	if itemm is EquipItem:
		for stat_mod in itemm.test_stat_increase:
			var stat_to_mod = PlayerManager.stats.get_stat(stat_mod.stat)
			stat_to_mod.remove_modifiers_from_source(item)
		for style in itemm.gain_atk_styles:
			PlayerManager.remove_damage_type(style)
		print("UNEQUIPPED : ", item.data.item_name)
	else:
		return

func equip_item(item : InventoryItem):
	if not item.data is EquipItem:
		return
	var slot =  _get_slot_from_enum(item.data.equip_slot)
	#if slot.get_slot_item() and slot.can_drop_data(item):
		#unequip_slot(item.data.equip_slot)
	if slot.can_drop_data(item):
		slot.drop_data(item)

func unequip_slot(slot : EquipItem.EquipSlot):
	var slot_to_uneq = _get_slot_from_enum(slot)
	var item = slot_to_uneq.get_slot_item()
	if item:
		%Inv.add_item_to_free_slot(item) # Add the unequipped item back to the inventory
		#slot_to_uneq.clear_slot_item() # Clear the equipment slot

func _get_slot_from_enum(equip_slot : EquipItem.EquipSlot) -> InventorySlot:
	match equip_slot:
		EquipItem.EquipSlot.MAIN_HAND:
			return main_hand_slot
		EquipItem.EquipSlot.OFF_HAND:
			return off_hand_slot
		EquipItem.EquipSlot.HELM:
			return head_slot
		EquipItem.EquipSlot.CHEST:
			return chest_slot
		EquipItem.EquipSlot.LEGS:
			return leg_slot
		EquipItem.EquipSlot.BOOTS:
			return foot_slot
		EquipItem.EquipSlot.GLOVES:
			return glove_slot
	return null

#NOTE: TEMP FUNC
func is_equiped(item : InventoryItem) -> bool:
	for slot in all_slots:
		if slot.get_slot_item() == item:
			return true
	return false
