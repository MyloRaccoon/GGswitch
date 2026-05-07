extends Node2D

@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	label.text = "Switch 'cool' is true" \
		if GGswitch.get_switch('cool') else \
		"Switch 'cool' is false"


func _on_button_pressed() -> void:
	GGswitch.switch("cool")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2.tscn")
