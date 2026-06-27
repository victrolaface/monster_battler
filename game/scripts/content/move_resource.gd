class_name MoveResource extends Resource

@export var name: String
@export var max_usages: int
@export var use_effects: Array[TargetedEffect]
@export var type: MonsterType.Type
@export var use_message: String = "{user_name} uses {move_name}"
