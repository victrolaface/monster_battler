class_name AddCondition extends TargetedEffect

@export var condition_resource: ConditionResource

func _do(doer: Monster, source: Move, game_state: GameState):
	var target = doer if target_self else MonsterController.get_monster_opponent(doer)
	
	# create a condition from ConditionResource and add it to the target
	MonsterController.instantiate_condition_on_monster(target, condition_resource)
	return
