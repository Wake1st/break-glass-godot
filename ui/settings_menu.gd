class_name SettingsMenu
extends SubMenu


func _on_return_pressed() -> void:
	menu_selected.emit(Menus.MAIN)
