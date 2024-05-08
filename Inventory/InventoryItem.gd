extends TextureRect
class_name InventoryItem

@export var data : ItemData
@export var current_slot : InventorySlot

func init(d : ItemData):
	data = d

func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	if data:
		texture = data.texture
		tooltip_text = "%s\n%s" % [data.item_name, data.item_description]

func _get_drag_data(at_position : Vector2):
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_positon : Vector2):
	var t = TextureRect.new()
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	t.texture = data.texture
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_positon)
	
	var c := Control.new()
	c.add_child(t)
	return c
