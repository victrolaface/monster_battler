class_name DoDamage extends TargetedEffect

# @export var base_damage: int

func _do(doer: Monster, source: Move, game_state: GameState):
	var target = MonsterController.get_monster_opponent(doer)
	MonsterController.adjust_monster_hitpoints(target, -base_damage)
	Events.request_log.emit("{doer_name} hits {target_name} for {amt} damage"\
		.format({"doer_name": doer.name, "target_name": target.name, "amt": base_damage}))
	
	
	print("Doing the effect %d"%[base_damage])
	
	
	var type_advantage_coefficient = MonsterType.get_type_advantage_coefficient(source.type, target.species.type)
	
	print(type_advantage_coefficient)
	
	var amt = base_damage * type_advantage_coefficient
	
	
	
	var effectiveness = MonsterType.get_type_effectiveness(source.type, target.type)
	
	if effectiveness == MonsterType.Effectiveness.STRONG:
		Events.request_log.emit("It's extra effective!")
	elif effectiveness == MonsterType.Effectiveness.WEAK:
		Events.request_log.emit("It's weak.")
	
	Events.request_log.emit("{doer_name} hits {target_name} for {amt} damage)"\
		.format({"doer_name": doer.name, "target_name": target.name, "amt": amt}))
	
