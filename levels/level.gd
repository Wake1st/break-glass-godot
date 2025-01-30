class_name Level
extends Node2D

signal level_finished(platforms_broken: int)
signal level_failed()

@onready var fallBoundary: FallBoundary = $FallBoundary
@onready var goal: Goal = $Goal
@onready var player: Player = $Player
@onready var platformParent: Node2D = $PlatformParent

var endTimer: Timer = Timer.new()
var currentNumber: int
var isPractice: bool
var platformsBroken: int


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
	
	for platform: Platform in platformParent.get_children():
		platform.platform_broken.connect(handle_platform_broken)


func handle_platform_broken() -> void:
	platformsBroken += 1


func handle_fall_failure() -> void:
	get_tree().paused = true
	level_failed.emit()


func handle_goal_crossed() -> void:
	endTimer.start()


func _on_endtimer_timeout() -> void:
	get_tree().paused = true
	level_finished.emit(platformsBroken)



###	DEV-ONLY: Skips the level 
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("debug_level_skip"):
		handle_goal_crossed()
