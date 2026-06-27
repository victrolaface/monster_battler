class_name DoDamage extends TargetedEffect

@export var base_damage: int

func do(doer: Monster, source: Move, game_state: GameState):
	var target = MonsterController.get_monster_opponent(doer)
	
	var type_advantage_coefficient = MonsterType.get_type_advantage_coefficient(
		source.resource.type, target.species.type)
	
	print(type_advantage_coefficient)
	
	var amt = base_damage * type_advantage_coefficient
	
	MonsterController.adjust_monster_hitpoints(target, -amt)
	
	var effectiveness = MonsterType.get_type_effectiveness(
		source.resource.type, target.species.type)
	
	if effectiveness == MonsterType.Effectiveness.STRONG:
		Events.request_log.emit("It's extra effective!")
	elif effectiveness == MonsterType.Effectiveness.WEAK:
		Events.request_log.emit("It's weak.")
	
	Events.request_log.emit("{doer_name} hits {target_name} for {amt} damage)"\
		.format({"doer_name": doer.name, "target_name": target.name, "amt": amt}))
	
