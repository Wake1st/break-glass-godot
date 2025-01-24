class_name SettingsMenu
extends SubMenu


func _on_return_pressed() -> void:
	print("return selected")
	menu_selected.emit(Main.MENUS.MAIN)
