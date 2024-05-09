extends Node

const MELEE_DEFENSE = preload("res://Combat/DefenseStyles/MeleeDefense.tres")

signal styles_updated

var player : Player
var equip_inv : EquipInventory
var stats : CharacterStats = preload("res://test_stats.tres")

var cur_dmg_type : DamageType 
var cur_def_style : DefenseStyle = MELEE_DEFENSE

var known_dmg_types : Array[DamageType]
var known_def_styles : Array[DefenseStyle]

var cur_health : int
var cur_health_label 
var health_bar
var max_health_label

func _ready():
	cur_health = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value

func get_hit(attack : Attack):
	var hit =  cur_def_style.modify_attack(attack, stats)
	cur_health -= attack.damage_amount
	update_health_bar()

func update_health_bar():
	cur_health_label.text = str(cur_health)
	health_bar.value = cur_health
	health_bar.max_value = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value
	max_health_label.text = str(stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value)

func get_damage_types() -> Array[DamageType]:
	return known_dmg_types

func add_damage_type(style : DamageType):
	known_dmg_types.append(style)
	styles_updated.emit()
func remove_damage_type(style : DamageType):
	known_dmg_types.erase(style)
	styles_updated.emit()
func get_attack() -> Attack:
	cur_dmg_type = equip_inv.get_weapon().dmg_type
	return Attack.new(cur_dmg_type,stats)
