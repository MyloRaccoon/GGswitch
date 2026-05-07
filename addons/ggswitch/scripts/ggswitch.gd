@tool
extends Object
class_name GGswitch

const SAVE_PATH := "res://switches.tres"

static func load_switches() -> Dictionary:
	var res = load(SAVE_PATH)
	if not res:
		res = SwitchesResource.new()
	return res.switches

static func save_switches(switches: Dictionary):
	var res = SwitchesResource.new()
	res.switches = switches
	ResourceSaver.save(res, SAVE_PATH)


static func switch_exists(key: String) -> bool:
	var switches = load_switches()
	return key in switches.keys()

static func get_switch(key: String) -> bool:
	var switches = load_switches()
	if not switch_exists(key):
		return false
	else:
		return switches[key]

static func switch(key: String) -> bool:
	var switches = load_switches()
	switches[key] = !get_switch(key)
	save_switches(switches)
	return switches[key]

static func set_switch(key: String, value: bool):
	var switches = load_switches()
	switches[key] = value
	save_switches(switches)

static func delete_switch(key: String):
	var switches = load_switches()
	switches.erase(key)
	save_switches(switches)
