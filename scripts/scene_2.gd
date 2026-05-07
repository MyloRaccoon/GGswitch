extends Node2D

func _process(_delta: float) -> void:
	$Label.text = "Switch 'cool' is on true" \
		if GGswitch.get_switch('cool') else \
		"Switch 'cool' is on false"
