extends Node2D

@onready var goal: Goal = $Goal


func _ready() -> void:
	goal.finished.connect(handle_goal_crossed)


func handle_goal_crossed() -> void:
	print("finished level 1!")