class_name PracticeStage
extends Panel

signal practice_level_selected(scene: PackedScene)

@export var stageName: String:
	set(value):
		(get_node("%Title") as Label).text = "%s Stage" % value

@export var levelAScene: PackedScene
@export var levelBScene: PackedScene
@export var levelCScene: PackedScene
@export var levelDScene: PackedScene

@onready var levelABtn: Button = %Level_A
@onready var levelBBtn: Button = %Level_B
@onready var levelCBtn: Button = %Level_C
@onready var levelDBtn: Button = %Level_D


func enable_level(number: int) -> void:
	match number:
		0: levelABtn.disabled = false
		1: levelBBtn.disabled = false
		2: levelCBtn.disabled = false
		3: levelDBtn.disabled = false


func _on_level_a_pressed() -> void:
	print("pressed level a")
	practice_level_selected.emit(levelAScene)


func _on_level_b_pressed() -> void:
	print("pressed level b")
	practice_level_selected.emit(levelBScene)


func _on_level_c_pressed() -> void:
	print("pressed level c")
	practice_level_selected.emit(levelCScene)


func _on_level_d_pressed() -> void:
	print("pressed level d")
	practice_level_selected.emit(levelDScene)
