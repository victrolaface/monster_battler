class_name MonsterType

enum Type {
	NORMAL,
	PURE,
	WATER,
	FIRE,
	PLANT
}

enum Effectiveness {
	NEUTRAL,
	WEAK,
	STRONG
}

const EFFECTIVENESS_BY_TYPE: Dictionary[Type, Dictionary] = {
	Type.NORMAL: {},
	Type.FIRE: {
		Type.PLANT: Effectiveness.STRONG,
		Type.WATER: Effectiveness.WEAK
	},
	Type.WATER: {
		Type.FIRE: Effectiveness.STRONG,
		Type.PLANT: Effectiveness.WEAK
	},
	Type.PLANT: {
		Type.WATER: Effectiveness.STRONG,
		Type.FIRE: Effectiveness.WEAK
	}
}
