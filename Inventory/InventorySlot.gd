extends PanelContainer
class_name InventorySlot

const BOOTS_ICON = preload("res://Art/InventoryIcons/BootsIcon.png")
const CHEST_ICON = preload("res://Art/InventoryIcons/ChestIcon.png")
const GLOVES_ICON = preload("res://Art/InventoryIcons/GlovesIcon.png")
const HELM_ICON = preload("res://Art/InventoryIcons/HelmIcon.png")
const LEGS_ICON = preload("res://Art/InventoryIcons/LegsIcon.png")
const MAIN_HAND_ICON = preload("res://Art/InventoryIcons/MainHandIcon.png")
const OFF_HAND_ICON = preload("res://Art/InventoryIcons/OffHandIcon.png")


@export var slot_type_icon = TextureRect

@export var type : ItemData.SlotFlags
@export var pos : Vector2
@export var slot_item : InventoryItem

var is_equip_slot : bool
signal data_changed
signal item_removed(InventoryItem)
signal item_set(InventoryItem)

func set_slot_type(type_to_set : ItemData.SlotFlags):
	match type_to_set:
		ItemData.SlotFlags.OFFHAND:
			slot_type_icon.texture = OFF_HAND_ICON
		ItemData.SlotFlags.MAINHAND:
			slot_type_icon.texture = MAIN_HAND_ICON
		ItemData.SlotFlags.HELM:
			slot_type_icon.texture = HELM_ICON
		ItemData.SlotFlags.CHEST:
			slot_type_icon.texture = CHEST_ICON
		ItemData.SlotFlags.LEGS:
			slot_type_icon.texture = LEGS_ICON
		ItemData.SlotFlags.BOOTS:
			slot_type_icon.texture = BOOTS_ICON
		ItemData.SlotFlags.GLOVES:
			slot_type_icon.texture = GLOVES_ICON
		ItemData.SlotFlags.ANY:
			slot_type_icon.texture = null
	type = type_to_set
	

func init(size : Vector2, position : Vector2 = Vector2(0,0)) -> void:
	custom_minimum_size = size
	pos = position
	set_slot_type(type)

#NOTE: This is the godot built in drag
func _can_drop_data(at_position : Vector2, data : Variant):
	return can_drop_data(data)

func can_drop_data(data : InventoryItem) -> bool:
	if data is InventoryItem:
		if type == ItemData.SlotFlags.ANY:
			if not get_slot_item(): #IF WE HAVE NO ITEM
				return true
			else:
				if type == data.data.item_type:
					return true
			return get_slot_item().data.item_type == data.data.item_type
		else:
			return data.data.item_type == type
	return false

#NOTE: As of right now if there is no previous parent you can't drop, because of reparent
func drop_data(data : InventoryItem):
	var item = get_slot_item()
	if item:
		if item == data:
			return
		var old_slot = data.get_parent() #SWAP HERE
	 #If there was an old slot, clear this one and drop into new
		if old_slot is InventorySlot:
			clear_slot_item()
			old_slot.drop_data(item)
	_set_slot_item(data)
	data_changed.emit()

func _drop_data(at_position, data):
	drop_data(data)

func use_slot():
	if slot_item:
		if slot_item is InventoryItem:
			if slot_item.data is EquipItem:
				if PlayerManager.equip_inv.is_equiped(slot_item):
					PlayerManager.equip_inv.unequip_slot(slot_item.data.equip_slot)
				else:
					PlayerManager.equip_inv.equip_item(slot_item)

func get_slot_item() -> InventoryItem:
	if slot_item:
		return slot_item
	return null

func _set_slot_item(data : InventoryItem) -> void:
	var old_slot = data.get_parent()
	if old_slot:
		data.reparent(self)
		if old_slot is InventorySlot:
			old_slot.clear_slot_item()
	else:
		add_child(data)
	slot_item = data
	item_set.emit(data)

func clear_slot_item():
	if get_slot_item():
		item_removed.emit(get_slot_item())
	slot_item = null

func _input(event):
	if event.is_action_pressed("EquipMousePos"):
		if get_global_rect().has_point(get_global_mouse_position()):
			use_slot()
