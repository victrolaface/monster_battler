extends Node

var game_state: GameState

func _ready() -> void:
	Events.on_new_game_state_created.connect(func(state): game_state = state)
	
func get_monster_opponent(monster: Monster) -> Monster:
	if monster == game_state.player_monster:
		return game_state.opponent_monster
		
	if monster == game_state.opponent_monster:
		return game_state.player_monster
	
	return null
	
func adjust_monster_hitpoints(monster: Monster, amount: int):
	monster.hp += amount
	
	# TODO: add check for fainting
	Events.on_monster_updated.emit(monster)
	
func use_monster_move_at_index(monster: Monster, index: int):
	var move = monster.moves[index]
	var use_message = move.resource.use_message
	
	for effect in move.resource.use_effects:
		effect._do(monster, move, game_state)
	
func create_monster(species: SpeciesResource, nickname: String = "") -> Monster:
	var monster = Monster.new()
	monster.species = species
	monster.hp = species.max_hp
	monster.nickname = nickname
	
	var moves: Array[Move] = []
	
	for move_resource in species.starter_moves:
		var move = Move.new()
		move.resource = move_resource
		move.usages = move_resource.max_usages
		moves.append(move)
	
	monster.moves = moves
	
	return monster
	
