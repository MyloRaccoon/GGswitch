extends Node2D

@onready var label: Label = $Label
@onready var switches_panel: ItemList = $switches_panel

@onready var on_icon = preload("res://addons/ggswitch/assets/ON.png")
@onready var off_icon = preload("res://addons/ggswitch/assets/OFF.png")

func _ready() -> void:
	GGswitch._init()

func update_switch_panel():
	switches_panel.clear()
	for switch in GGswitch.switches:
		create_switch_ui(switch, GGswitch.get_switch(switch))

func create_switch_ui(title: String, value: bool):
	var icon = on_icon if value else off_icon
	switches_panel.add_item(title, icon)

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	update_switch_panel()
	label.text = "Switch 'cool' is true" \
		if GGswitch.get_switch('cool') else \
		"Switch 'cool' is false"


func _on_button_pressed() -> void:
	GGswitch.switch("cool")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2.tscn")


func _on_btn_save_pressed() -> void:
	var res = GGswitch.get_current_state_ressource()
	ResourceSaver.save(res, "save.tres")


func _on_btn_load_pressed() -> void:
	var res = ResourceLoader.load("save.tres")
	GGswitch.load_state_ressource(res)
