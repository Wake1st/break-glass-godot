class_name PlayMenu
extends SubMenu

signal level_selected(scene: PackedScene)

@onready var stage2Btn: Button = %PlayStage_2
@onready var stage3Btn: Button = %PlayStage_3
@onready var stage4Btn: Button = %PlayStage_4

var stage1Scene: PackedScene = load("res://levels/level_1.tscn")
var stage2Scene: PackedScene = load("res://levels/level_5.tscn")
# var stage3Scene: PackedScene = load("res://levels/level_9.tscn")
# var stage4Scene: PackedScene = load("res://levels/level_13.tscn")


func enable_stage(number: int) -> void:
	match number:
		2: stage2Btn.disabled = false
		3: stage3Btn.disabled = false
		4: stage4Btn.disabled = false


func _on_return_pressed() -> void:
	menu_selected.emit(Menus.MAIN)


func _on_play_stage_1_pressed() -> void:
	level_selected.emit(stage1Scene)


func _on_play_stage_2_pressed() -> void:
	level_selected.emit(stage2Scene)


# func _on_play_stage_3_pressed() -> void:
# 	level_selected.emit(stage3Scene)


# func _on_play_stage_4_pressed() -> void:
# 	level_selected.emit(stage4Scene)
