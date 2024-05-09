extends Node2D
class_name EnemyManager

signal enemy_spawned(enemy : Enemy)

@export var enemy_scene : PackedScene
@export var spawn_rect : CollisionShape2D

var enemies : Array[Enemy]

func spawn_enemy(data : EnemyData, position):
	var es = enemy_scene.instantiate() as Enemy
	add_child(es)
	es.init_enemy(data)
	var spawn_pos_x = randi_range(0,spawn_rect.shape.get_rect().size.x)
	var spawn_pos_y = randi_range(0,spawn_rect.shape.get_rect().size.y)
	es.global_position = Vector2(spawn_pos_x,spawn_pos_y)
	enemies.append(es)
	es.enemy_dead.connect(remove_enemy)
	enemy_spawned.emit(es)

func remove_enemy(enemy : Enemy):
	enemies.erase(enemy)
	enemy.queue_free()
