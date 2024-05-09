extends Node2D

@export var test_add_tem : ItemData
@export var stat_mod : StatModifier

@export var test_enemy_data : EnemyData
@export var enemy_to_init : Enemy

#@export var temp_style_button : PackedScene
@onready var attack_timer = $CanvasLayer/PlayerStuff/AttackTimer
@onready var enemy_manager = $EnemyManager


# Called when the node enters the scene tree for the first time.
func _ready():
	#PlayerManager.styles_updated.connect(temp_make_styles)
	PlayerManager.health_bar = $CanvasLayer/PlayerStuff/HealthBar
	PlayerManager.cur_health_label = $CanvasLayer/PlayerStuff/HealthBar/HBoxContainer/CurHealth
	PlayerManager.max_health_label = $CanvasLayer/PlayerStuff/HealthBar/HBoxContainer/MaxHealth

	$CanvasLayer/PlayerStuff/PlayerAttackTimer.start(PlayerManager.stats.get_stat(\
	CharacterStats.StatType.ATTACK_SPEED).value)

#func temp_make_styles():
	#for child in $CanvasLayer/VBoxContainer.get_children():
		#child.queue_free()
	#for style in PlayerManager.get_damage_types():
		#var buttong = temp_style_button.instantiate()
		#$CanvasLayer/VBoxContainer.add_child(buttong)
		#buttong.init_button(style)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/PlayerStuff/AttackTimer.value = $CanvasLayer/PlayerStuff/PlayerAttackTimer.time_left
	pass

func _input(event):
	if event.is_action_pressed("ZTEST"):
		enemy_manager.spawn_enemy(test_enemy_data, position)
	if event.is_action_pressed("XTEST"):
		PlayerManager.stats.apply_modifier(stat_mod, self)



func _on_player_attack_timer_timeout():
	var attack = PlayerManager.get_attack()
	var selected = get_tree().get_nodes_in_group("selected")
	var hit_targets : Array[Enemy]
	hit_targets.clear()
	for possible_target in selected:
		var parent = possible_target.get_parent()
		if parent is Enemy:
			hit_targets.append(parent)
	for target in hit_targets:
		target.get_attacked(attack)
	var atk_speed = PlayerManager.stats.get_stat(CharacterStats.StatType.ATTACK_SPEED).value
	$CanvasLayer/PlayerStuff/AttackTimer.max_value = atk_speed
	$CanvasLayer/PlayerStuff/PlayerAttackTimer.start(atk_speed)

