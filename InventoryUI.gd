extends GridContainer
class_name InventoryUI

@export var slot_scene : PackedScene

@export var test_load_item : ItemData
@export var test_load_item2 : ItemData

@export var inventory_rows = 2
@export var inventory_columns = 2

var slots : Array[InventorySlot]

func _ready():
	#for child in get_children():
		#child.queue_free()
	columns = inventory_columns
	for i in inventory_rows:
		for j in inventory_columns:
			var slot := slot_scene.instantiate()
			slot.init(Vector2(32,32), Vector2(i,j))
			slots.append(slot)
			%Inv.add_child(slot)
	make_and_add_item(test_load_item)
	make_and_add_item(test_load_item2)

func add_item_to_free_slot(item : InventoryItem) -> bool:
	for child in get_children():
		if not child.get_slot_item():
			if child.can_drop_data(item):
				child.drop_data(item)
				return true
	return false

func make_and_add_item(item_data : ItemData):
	var to_add := InventoryItem.new()
	var item_data_to_add = item_data.duplicate()
	to_add.init(item_data_to_add)
	to_add.hide()
	add_child(to_add)
	if not add_item_to_free_slot(to_add):
		to_add.queue_free()
	to_add.show()
