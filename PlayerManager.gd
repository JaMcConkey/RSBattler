extends Node

const MELEE_DEFENSE = preload("res://Combat/DefenseStyles/MeleeDefense.tres")
#const MELEE = preload("res://Combat/DamageTypes/Melee.tres")

signal styles_updated

var player : Player
var equip_inv : EquipInventory
var stats : CharacterStats = preload("res://test_stats.tres")

var cur_atk_style : AttackStyle 
var cur_def_style : DefenseStyle = MELEE_DEFENSE

var known_atk_styles : Array[AttackStyle]
var known_def_styles : Array[DefenseStyle]

var cur_health : int
var cur_health_label 
var health_bar
var max_health_label

func _ready():
	cur_health = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value

func get_hit(attack : Attack):
	print("PRE-DEF AMOUNT : ",attack.damage_amount)
	var hit =  cur_def_style.modify_attack(attack, stats)
	cur_health -= attack.damage_amount
	update_health_bar()

func update_health_bar():
	cur_health_label.text = str(cur_health)
	health_bar.value = cur_health
	health_bar.max_value = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value
	max_health_label.text = str(stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value)

func get_damage_types() -> Array[AttackStyle]:
	return known_atk_styles

func add_damage_type(style : AttackStyle):
	known_atk_styles.append(style)
	styles_updated.emit()
func remove_damage_type(style : AttackStyle):
	known_atk_styles.erase(style)
	styles_updated.emit()
func get_attack() -> Attack:
	return Attack.new(cur_atk_style,stats)
