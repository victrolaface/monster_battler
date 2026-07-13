class_name AVFXInstance extends Node

var target: Monster
var resource: AVFXResource

func _init(res,targ):
	resource = res
	target = targ
	
func execute():
	resource._do(self)

func finish():
	AvfxManager.remove_effect(self)
