@tool
extends EditorPlugin

var control: Control

func _enable_plugin() -> void:
	pass

func _disable_plugin() -> void:
	pass


func _enter_tree() -> void:
	control = preload("res://addons/ggswitch/scenes/main_panel.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, control)


func _exit_tree() -> void:
	remove_control_from_docks(control)
	control.free
