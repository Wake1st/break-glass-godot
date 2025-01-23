class_name Level
extends Node2D

signal level_finished(nextLevel: int)

@onready var goal: Goal = $Goal


func _ready() -> void:
	goal.finished.connect(handle_goal_crossed)


func handle_goal_crossed() -> void:
	var currentNumber: int = name.right(1) as int
	level_finished.emit(currentNumber + 1)
