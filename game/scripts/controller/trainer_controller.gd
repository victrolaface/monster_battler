extends Node

var game_state: GameState

func _ready() -> void:
	Events.on_new_game_state_created.connect(func(state): game_state = state)
		
func add_trainer_monster_to_battle(trainer: Trainer, monster_index: int):
	var monster = trainer.monsters[monster_index]
	trainer.current_monster_index = monster_index
	Events.on_monster_added_to_battle.emit(monster, game_state.player == trainer)
	
