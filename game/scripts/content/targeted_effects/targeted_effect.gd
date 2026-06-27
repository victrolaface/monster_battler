class_name TargetedEffect extends Resource

@export var base_damage: int

func _do(doer: Monster, source: Move, game_state: GameState):
	var target = null
