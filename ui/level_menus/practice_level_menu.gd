class_name PracticeLevelMenu
extends Panel

signal menu_selected()
signal prev_selected()
signal replay_selected()
signal next_selected()

@onready var prevBtn: Button = %Prev
@onready var nextBtn: Button = %Next


func disable_prev(disable: bool) -> void:
	prevBtn.disabled = disable


func disable_next(disable: bool) -> void:
	nextBtn.disabled = disable


func _on_menu_pressed():
	menu_selected.emit()


func _on_prev_pressed():
	prev_selected.emit()


func _on_replay_pressed():
	replay_selected.emit()


func _on_next_pressed():
	next_selected.emit()
