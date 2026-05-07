extends Node2D

@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Switch 'cool' exists" \
		if GGswitch.switch_exists('cool') else \
		"Switch 'cool' doesn't exists"
