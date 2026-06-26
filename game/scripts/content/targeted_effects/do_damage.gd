class_name DoDamage extends TargetedEffect

@export var base_damage: int

func do(doer: Monster, source: Move, game_state: GameState):
	var target = null # todo find the target
	print("Doing the effect! %d"%[base_damage])
