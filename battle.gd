extends Control

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false

func _ready() -> void:
	set_health($Panel/PlayerData/ProgressBar, State.current_health, State.max_health)
	set_health($EnemyContainer/ProgressBar, BaseEnemy.health, BaseEnemy.health)
	
	current_player_health = State.current_health
	current_enemy_health = BaseEnemy.health
	

func set_health(progress_bar, health, max_health) -> void:
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]
	
func enemy_turn() -> void:
	
	if is_defending:
		is_defending = false
	else:
		current_player_health = max(0, current_player_health - BaseEnemy.damage)
	set_health($Panel/PlayerData/ProgressBar, current_player_health, State.max_health)
	
		

func _on_button_3_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, BaseEnemy.health)
	
	enemy_turn()
		


func _on_button_2_pressed() -> void:
	is_defending = true
	
	await get_tree().create_timer(0.25).timeout
	
	enemy_turn()
