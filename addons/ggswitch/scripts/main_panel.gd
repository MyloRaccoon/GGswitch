@tool
extends Panel

@onready var popup_panel: ConfirmationDialog = $PopupPanel
@onready var line_edit: LineEdit = $PopupPanel/LineEdit
@onready var item_list: ItemList = $VBoxContainer/ItemList

@onready var on_texture := preload("res://addons/ggswitch/assets/ON.png")
@onready var off_texture := preload("res://addons/ggswitch/assets/OFF.png")

func _ready() -> void:
	update()


func update():
	item_list.clear()
	var idx = 0
	for switch in GGswitch.load_switches():
		item_list.add_item(switch)
		var texture = on_texture \
			if GGswitch.get_switch(switch) else \
			off_texture
		item_list.set_item_icon(idx, texture)
		idx += 1


func _on_btn_create_pressed() -> void:
	popup_panel.popup_centered(Vector2i.ZERO)


func _on_item_list_empty_clicked(at_position: Vector2, mouse_button_index: int) -> void:
	popup_panel.popup_centered(Vector2i.ZERO)


func _on_popup_panel_confirmed() -> void:
	var new_key := line_edit.text
	line_edit.text = ""
	item_list.add_item(new_key, off_texture)
	GGswitch.set_switch(new_key, false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_delete"):
		for index in item_list.get_selected_items():
			var key := item_list.get_item_text(index)
			GGswitch.delete_switch(key)
		update()


func _on_item_list_item_activated(index: int) -> void:
	var switch = item_list.get_item_text(index)
	var value = GGswitch.switch(switch)
	var texture = on_texture \
		if value else \
		off_texture
	item_list.set_item_icon(switch, texture)
