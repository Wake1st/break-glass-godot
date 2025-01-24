class_name Level
extends Node2D

signal level_failed(currentLevel: int)
signal level_finished(currentLevel: int)
signal level_quit()

@onready var fallBoundary: FallBoundary = $FallBoundary
@onready var goal: Goal = $Goal
@onready var player: Player = $Player

var endTimer: Timer = Timer.new()
var currentNumber: int
var isPractice: bool


func _ready() -> void:
	# unpause the game
	get_tree().paused = false

	# setup variables
	currentNumber = name.right(1) as int

	add_child(endTimer)
	endTimer.one_shot = true
	endTimer.wait_time = 0.6

	# connect signals
	goal.finished.connect(handle_goal_crossed)
	fallBoundary.passed_fall_boundary.connect(handle_fall_failure)
	endTimer.timeout.connect(_on_endtimer_timeout)

	player.resultMenu.menu_selected.connect(handle_menu_selected)
	player.resultMenu.next_selected.connect(handle_next_selected)
	player.failureMenu.menu_selected.connect(handle_menu_selected)
	player.failureMenu.reset_selected.connect(handle_reset_selected)


###	DEV-ONLY: Skips the level 
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("debug_level_skip"):
		handle_goal_crossed()


func handle_fall_failure() -> void:
	get_tree().paused = true
	player.failureMenu.visible = true


func handle_goal_crossed() -> void:
	endTimer.start()
	print("timer - started")


func _on_endtimer_timeout() -> void:
	print("timer - ended")
	get_tree().paused = true
	player.resultMenu.visible = true


func handle_next_selected() -> void:
	player.resultMenu.visible = false
	level_finished.emit(currentNumber)


func handle_reset_selected() -> void:
	player.failureMenu.visible = false
	level_failed.emit(currentNumber)


func handle_menu_selected() -> void:
	player.resultMenu.visible = false
	player.failureMenu.visisble = false
	level_quit.emit()
