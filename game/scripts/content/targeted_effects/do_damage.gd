class_name DoDamage extends TargetedEffect

@export var base_damage: int

func _do(doer: Monster, source: Move, game_state: GameState):
	var target = MonsterController.get_monster_opponent(doer)
	MonsterController.adjust_monster_hitpoints(target, -base_damage)
