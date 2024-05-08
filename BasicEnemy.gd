extends Node2D
class_name Enemy

signal targeted(Enemy)

@onready var select_area = $SelectArea
@onready var hovered = $hovered
@onready var selected = $selected
@onready var attack_timer = $AttackTimer

var cur_atk_style : AttackStyle
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
	start_attack()
	choose_damage_type()
	choose_def_style()
	pass

func choose_damage_type():
	cur_atk_style = data.choose_damage_type()
	$AttackTimerBar/PanelContainer/damage_type_Icon.texture = cur_atk_style.icon
	pass
func choose_def_style():
	cur_def_style = data.chose_defense_style()
	$DefStyle/Defense_Style_icon.texture = cur_def_style.icon
	pass

func get_attacked(attack : Attack):
	var hit = attack
	cur_def_style.modify_attack(hit,stats)
	cur_health -= hit.damage_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	select_area.hovered_changed.connect(show_hover)
	select_area.selection_toggled.connect(show_select)
	pass # Replace with function body.

func show_hover(state : bool):
	if not select_area.selected:
		hovered.visible = state

func show_select(state : bool):
	selected.visible = state
	targeted.emit(self)
	if state:
		hovered.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AttackTimerBar.value = attack_timer.time_left
	pass


func _on_attack_timer_timeout():
	print(stats.get_stat(CharacterStats.StatType.MELEE_POWER).value)
	var attack = Attack.new(cur_atk_style,stats)
	PlayerManager.get_hit(attack)
	choose_damage_type()

func start_attack():
	var atk_speed = stats.get_stat(CharacterStats.StatType.ATTACK_SPEED).value
	$AttackTimerBar.max_value = atk_speed
	attack_timer.start(atk_speed)
