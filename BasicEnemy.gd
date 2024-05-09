extends Node2D
class_name Enemy

signal targeted(Enemy)
signal enemy_dead(Enemy)

@onready var select_area = $SelectArea
@onready var hovered = $hovered
@onready var selected = $selected
@onready var attack_timer = $AttackTimer
@onready var range_def_labal = $StatsDisplay/HBoxContainer/RangedDef/Range_Def_labal
@onready var magic_def_label = $StatsDisplay/HBoxContainer/MagicDef/Magic_Def_label
@onready var melee_def_labal = $StatsDisplay/HBoxContainer/MeleeDef/Melee_Def_labal





var cur_dmg_type : DamageType
var cur_def_style : DefenseStyle
var stats : CharacterStats
var data : EnemyData

var cur_health : int : 
	set(v):
		var max = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value
		if v > max:
			v = max
		cur_health = v
		$HealthBar/HBoxContainer/CurHealth.text = str(cur_health)
		$HealthBar/HBoxContainer/MaxHealth.text = str(max) 
		$HealthBar.max_value = max
		$HealthBar.value = v

func init_enemy(enemy_data : EnemyData):
	data = enemy_data
	stats = enemy_data.enemy_stats.duplicate()
	cur_health = stats.get_stat(CharacterStats.StatType.MAX_HEALTH).value
	stats.stats_changed.connect(update_ui)
	start_attack()
	choose_damage_type()
	choose_def_style()
	update_ui(stats)
	pass

func update_ui(character_stats : CharacterStats):
	magic_def_label.text = str(character_stats.get_stat_by_string("magic_defense").value)
	melee_def_labal.text = str(character_stats.get_stat_by_string("melee_defense").value)
	range_def_labal.text = str(character_stats.get_stat_by_string("ranged_defense").value)
func choose_damage_type():
	cur_dmg_type = data.choose_damage_type()
	$AttackTimerBar/PanelContainer/Attack_Style_Icon.texture = cur_dmg_type.icon
	pass
func choose_def_style():
	cur_def_style = data.chose_defense_style()
	$DefStyle/Defense_Style_icon.texture = cur_def_style.icon
	pass

func get_attacked(attack : Attack):
	var hit = attack
	if cur_def_style:
		cur_def_style.modify_attack(hit,stats)
	cur_health -= hit.damage_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	select_area.hovered_changed.connect(show_hover)
	select_area.selection_toggled.connect(emit_selected)
	pass # Replace with function body.

func show_hover(state : bool):
	if not select_area.selected:
		hovered.visible = state

func emit_selected(state : bool):
	toggle_selected(state)
	if state:
		targeted.emit(self)

func toggle_selected(state : bool):
	hovered.visible = false
	selected.visible = state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AttackTimerBar.value = attack_timer.time_left
	pass


func _on_attack_timer_timeout():
	print(stats.get_stat(CharacterStats.StatType.MELEE_POWER).value)
	var attack = Attack.new(cur_dmg_type,stats)
	PlayerManager.get_hit(attack)
	choose_damage_type()

func start_attack():
	var atk_speed = stats.get_stat(CharacterStats.StatType.ATTACK_SPEED).value
	$AttackTimerBar.max_value = atk_speed
	attack_timer.start(atk_speed)

func die():
	enemy_dead.emit(self)
	pass
