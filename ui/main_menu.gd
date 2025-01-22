class_name MainMenu
extends Panel


signal menu_selected(scene: PackedScene)

@export var play_scene: PackedScene
@export var practice_scene: PackedScene
@export var settings_scene: PackedScene


func _on_play_pressed() -> void:
	menu_selected.emit(play_scene)


func _on_practice_pressed() -> void:
	menu_selected.emit(practice_scene)


func _on_settings_pressed() -> void:
	menu_selected.emit(settings_scene)
