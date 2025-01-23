class_name FailureMenu
extends Panel

signal menu_selected()
signal reset_selected()

@onready var menu: Button = %Menu
@onready var reset: Button = %Reset


func _on_reset_pressed() -> void:
	reset_selected.emit()


func _on_menu_pressed() -> void:
	menu_selected.emit()
