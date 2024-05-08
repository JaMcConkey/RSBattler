extends Control

@export var melee_atk_value : Label
@export var magic_atk_value : Label
@export var ranged_atk_value : Label
@export var melee_def_value : Label
@export var magic_def_value : Label
@export var ranged_def_value : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.stats.stats_changed.connect(update_ui)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_ui():
	pass

func update_ui(stats : CharacterStats):
	print("RECIEVED")
	melee_atk_value.text = str(stats.get_stat(CharacterStats.StatType.MELEE_POWER).value)
	melee_def_value.text = str(stats.get_stat(CharacterStats.StatType.MELEE_DEFENSE).value)
	magic_atk_value.text = str(stats.get_stat(CharacterStats.StatType.MAGIC_POWER).value)
	magic_def_value.text = str(stats.get_stat(CharacterStats.StatType.MAGIC_DEFENSE).value)
	ranged_atk_value.text = str(stats.get_stat(CharacterStats.StatType.RANGED_POWER).value)
	ranged_def_value.text = str(stats.get_stat(CharacterStats.StatType.RANGED_DEFENSE).value)
