class_name PracticeMenu
extends SubMenu

signal practice_level_selected(scene: PackedScene)

@onready var practiceStage1: PracticeStage = %PracticeStage_1
@onready var practiceStage2: PracticeStage = %PracticeStage_2
@onready var practiceStage3: PracticeStage = %PracticeStage_3
@onready var practiceStage4: PracticeStage = %PracticeStage_4


func enable_practice_level(level: int) -> void:
	var stage: int = ceil(level as float / 4.0)
	var sub_level: int = (level - 1) % 4

	match stage:
		1: practiceStage1.enable_level(sub_level)
		2: practiceStage2.enable_level(sub_level)
		3: practiceStage3.enable_level(sub_level)
		4: practiceStage4.enable_level(sub_level)


func _on_practice_level_selected(scene: PackedScene) -> void:
	practice_level_selected.emit(scene)


func _on_return_pressed() -> void:
	return_selected.emit()
