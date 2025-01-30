class_name FailureMenu
extends Panel

signal menu_selected()
signal reset_selected()

@onready var title = %Title
@onready var menu: Button = %Menu
@onready var reset: Button = %Reset


func set_title(reason: String = "FAILURE!") -> void:
	title.text = reason


func _on_reset_pressed() -> void:
	set_title()
	reset_selected.emit()


func _on_menu_pressed() -> void:
	set_title()
	menu_selected.emit()
