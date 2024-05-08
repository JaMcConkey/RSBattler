extends Resource
class_name CharacterStats

signal stats_changed(CharacterStats)

enum StatType {
	ATTACK_SPEED,
	MELEE_POWER,
	RANGED_POWER,
	MAGIC_POWER,
	MELEE_DEFENSE,
	RANGED_DEFENSE,
	MAGIC_DEFENSE,
	MAX_HEALTH,
	CRIT_CHANCE
}

@export var starting_attack_speed : int = 0
@export var starting_melee_power : int = 0
@export var starting_ranged_power : int = 0
@export var starting_magic_power : int = 0
@export var starting_melee_defense : int = 0
@export var starting_ranged_defense : int = 0
@export var starting_magic_defense : int = 0
@export var starting_max_health : int = 0
@export var starting_crit_chance : int = 0

var stats = {}

var init = false

func init_stats():
	stats = {
		StatType.ATTACK_SPEED: create_stat(starting_attack_speed),
		StatType.MELEE_POWER: create_stat(starting_melee_power),
		StatType.RANGED_POWER: create_stat(starting_ranged_power),
		StatType.MAGIC_POWER: create_stat(starting_magic_power),
		StatType.MELEE_DEFENSE: create_stat(starting_melee_defense),
		StatType.RANGED_DEFENSE: create_stat(starting_ranged_defense),
		StatType.MAGIC_DEFENSE: create_stat(starting_magic_defense),
		StatType.MAX_HEALTH: create_stat(starting_max_health),
		StatType.CRIT_CHANCE: create_stat(starting_crit_chance)
	}
	for stat in stats.values():
		stat.StatUpdated.connect(on_stat_updated)
	init = true

func create_stat(base_value: int) -> Stat:
	var stat = Stat.new()
	stat.base_value = base_value
	return stat

func on_stat_updated(stat):
	print("STAT UPDATED")
	stats_changed.emit(self)

func apply_modifier(mod, source):
	var to_mod = stats.get(mod.stat)
	if to_mod:
		to_mod.add_modifier(mod)

func remove_modifier(mod, source):
	var to_mod = stats.get(mod.stat)
	if to_mod:
		to_mod.remove_modifier(mod)

func get_stat(stat_type):
	if not init:
		init_stats()
	return stats.get(stat_type)
