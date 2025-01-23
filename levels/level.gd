class_name Level
extends Node2D

signal level_failed(currentLevel: int)
signal level_finished(currentLevel: int)

@onready var fallBoundary: FallBoundary = $FallBoundary
@onready var goal: Goal = $Goal

var isPractice: bool


func _ready() -> void:
	goal.finished.connect(handle_goal_crossed)
	fallBoundary.passed_fall_boundary.connect(handle_fall_failure)


###	DEV-ONLY: Skips the level 
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("debug_level_skip"):
		handle_goal_crossed()


func handle_fall_failure() -> void:
	level_failed.emit()


func handle_goal_crossed() -> void:
	var currentNumber: int = name.right(1) as int
	level_finished.emit(currentNumber)
