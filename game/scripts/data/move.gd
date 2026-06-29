class_name Move

@export var usages: int
@export var resource: MoveResource

var type: MonsterType.Type:
	get: return resource.type
