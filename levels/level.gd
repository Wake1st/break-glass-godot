class_name Level
extends Node2D

signal level_failed(currentLevel: int)
signal level_finished(currentLevel: int)
signal level_quit()

@onready var fallBoundary: FallBoundary = $FallBoundary
@onready var goal: Goal = $Goal

@onready var resultMenu: ResultMenu = %ResultMenu
@onready var failureMenu: FailureMenu = %FailureMenu

var currentNumber: int
var isPractice: bool


func _ready() -> void:
	# unpause the game
	get_tree().paused = false

	# collect values
	currentNumber = name.right(1) as int

	# connect signals
	goal.finished.connect(handle_goal_crossed)
	fallBoundary.passed_fall_boundary.connect(handle_fall_failure)

	resultMenu.menu_selected.connect(handle_menu_selected)
	resultMenu.next_selected.connect(handle_next_selected)
	failureMenu.menu_selected.connect(handle_menu_selected)
	failureMenu.reset_selected.connect(handle_reset_selected)


###	DEV-ONLY: Skips the level 
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("debug_level_skip"):
		handle_goal_crossed()


func handle_fall_failure() -> void:
	failureMenu.visible = true
	get_tree().paused = true


func handle_goal_crossed() -> void:
	resultMenu.visible = true
	get_tree().paused = true


func handle_next_selected() -> void:
	resultMenu.visible = false
	level_finished.emit(currentNumber)


func handle_reset_selected() -> void:
	failureMenu.visible = false
	level_failed.emit(currentNumber)


func handle_menu_selected() -> void:
	resultMenu.visible = false
	failureMenu.visisble = false
	level_quit.emit()
