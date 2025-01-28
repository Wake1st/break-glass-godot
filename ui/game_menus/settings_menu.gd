class_name SettingsMenu
extends SubMenu


func _on_return_pressed() -> void:
	menu_selected.emit(Main.MENUS.MAIN)


func _on_game_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), linear_to_db(value / 100)
	)


func _on_music_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), linear_to_db(value / 100)
	)


func _on_sfx_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"), linear_to_db(value / 100)
	)
