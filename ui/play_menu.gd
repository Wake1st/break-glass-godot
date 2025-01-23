class_name PlayMenu
extends SubMenu

signal level_selected(scene: PackedScene)

var stage1Scene: PackedScene = load("res://levels/level_1.tscn")
# var stage2Scene: PackedScene = load("res://levels/level_5.tscn")
# var stage3Scene: PackedScene = load("res://levels/level_9.tscn")
# var stage4Scene: PackedScene = load("res://levels/level_13.tscn")


func _on_return_pressed() -> void:
	return_selected.emit()


func _on_play_stage_1_pressed() -> void:
	level_selected.emit(stage1Scene)


# func _on_play_stage_2_pressed() -> void:
# 	level_selected.emit(stage2Scene)


# func _on_play_stage_3_pressed() -> void:
# 	level_selected.emit(stage3Scene)


# func _on_play_stage_4_pressed() -> void:
# 	level_selected.emit(stage4Scene)
