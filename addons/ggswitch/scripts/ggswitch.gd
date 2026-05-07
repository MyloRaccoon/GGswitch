@tool
extends Object
class_name GGswitch

const SAVE_PATH := "res://switches.tres"

static var defaults := {}
static var switches := {}
static var initialized := false


static func _load_defaults():
	var res = load(SAVE_PATH) \
		if ResourceLoader.exists(SAVE_PATH) else \
		SwitchesResource.new()
	defaults = res.switches.duplicate(true)

static func _save_defaults():
	var res = SwitchesResource.new()
	res.switches = defaults
	ResourceSaver.save(res, SAVE_PATH)


static func _add_switch(key: String):
	if _switch_default_exists(key): push_error("Can't add switch '", key, "': switch already exists")
	defaults[key] = false

static func _delete_switch(key: String):
	if not _switch_default_exists(key): push_error("Can't delete switch '", key, "': switch doesn't exists")
	defaults.erase(key)

static func _switch_default(key: String) -> bool:
	if not _switch_default_exists(key): 
		push_error("Can't switch switch '", key, "': switch doesn't exists")
		return false
	defaults[key] = !defaults[key]
	return defaults[key]

static func _get_switch_default(key: String):
	if not _switch_default_exists(key): push_error("Can't get switch '", key, "': switch doesn't exists")
	return defaults[key]

static func _switch_default_exists(key: String) -> bool:
	return key in defaults.keys()


static func _init():
	if initialized: return
	initialized = true
	_load_defaults()
	var res: SwitchesResource = load(SAVE_PATH)
	if res: switches = res.switches.duplicate(true)

static func _switch_exists(key: String) -> bool:
	return key in switches.keys()


static func get_switch(key: String) -> bool:
	_init()
	if not _switch_exists(key):
		return false
	else:
		return switches[key]

static func switch(key: String) -> bool:
	_init()
	if not key in switches: push_warning("switch '", key, "' not declared with editor")
	switches[key] = !get_switch(key)
	return switches[key]

static func set_switch(key: String, value: bool):
	_init()
	if not key in switches: push_warning("switch '", key, "' not declared with editor")
	switches[key] = value
