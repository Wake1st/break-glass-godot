class_name ResultMenu
extends Panel

signal menu_selected()
signal next_selected()

@onready var time: ResultContainer = %TimeContainer
@onready var glass: ResultContainer = %GlassContainer
@onready var score: ResultContainer = %ScoreContainer

@onready var menu: Button = %Menu
@onready var next: Button = %Next


func display_result(result: LevelResult) -> void:
	time.set_value(result.time)
	glass.set_value(result.glass)
	score.set_value(result.score)


func _on_next_pressed() -> void:
	next_selected.emit()


func _on_menu_pressed() -> void:
	menu_selected.emit()
