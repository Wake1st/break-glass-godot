class_name PracticeLevelMenu
extends Panel

signal menu_selected()
signal prev_selected()
signal replay_selected()
signal next_selected()


func _on_menu_pressed():
	menu_selected.emit()


func _on_prev_pressed():
	prev_selected.emit()


func _on_replay_pressed():
	replay_selected.emit()


func _on_next_pressed():
	next_selected.emit()
