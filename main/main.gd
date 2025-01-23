class_name Main
extends Node

@onready var mainMenu: MainMenu = %MainMenu
@onready var playMenu: PlayMenu = %PlayMenu
@onready var practiceMenu: PracticeMenu = %PracticeMenu
@onready var settingsMenu: SettingsMenu = %SettingsMenu

@onready var levelRoot: Node2D = $LevelRoot
@onready var endLevelTimer: Timer = $EndTimer

var currentMenu: Panel
var currentLevel: Level
var nextLevelId: int
var levelList: LevelList = LevelList.new()

var highestLevelId: int = 0
var highestStage: int = 0


func _ready() -> void:
	# first, pause the game
	get_tree().paused = true

	# menu setup
	currentMenu = mainMenu
	
	mainMenu.menu_selected.connect(handle_menu_change)
	playMenu.return_selected.connect(handle_return_to_main)
	practiceMenu.return_selected.connect(handle_return_to_main)
	settingsMenu.return_selected.connect(handle_return_to_main)

	playMenu.level_selected.connect(handle_level_select)
	practiceMenu.practice_level_selected.connect(handle_practice_level_select)

	# unlock the first level for practice
	practice_unlock_check(1)



func handle_menu_change(sceneName: String) -> void:
	currentMenu.visible = false

	# make menu visible
	match sceneName:
		"play": currentMenu = playMenu
		"practice": currentMenu = practiceMenu
		"settings": currentMenu = settingsMenu
	
	currentMenu.visible = true


func handle_return_to_main() -> void:
	currentMenu.visible = false
	currentMenu = mainMenu
	currentMenu.visible = true


func handle_level_select(scene: PackedScene) -> void:
	if currentLevel != null:
		disconnect_level(currentLevel)
	
	# swap levels
	currentLevel = setup_level(scene)
	
	# disable the current menu
	currentMenu.visible = false


func handle_practice_level_select(scene:PackedScene) -> void:
	if currentLevel != null:
		disconnect_level(currentLevel)
	
	# swap levels
	currentLevel = setup_level(scene, true)
	
	# disable the current menu
	currentMenu.visible = false


func handle_level_failure() -> void:
	disconnect_level(currentLevel)
	handle_return_to_main()


func handle_next_level(levelId) -> void:
	# create a time buffer to avoid "sudden change" shock
	nextLevelId = levelId + 1
	endLevelTimer.start()


func _on_end_timer_timeout() -> void:
	# disconnect current level
	disconnect_level(currentLevel)

	# setup new level
	var scene = levelList.levels[nextLevelId]
	currentLevel = setup_level(scene)
	
	# set the highest level for training
	practice_unlock_check(nextLevelId)

	# every 4th level should unlock the next stage
	stage_unlock_check(nextLevelId)


func disconnect_level(level:Level) -> void:
	level.visible = false
	levelRoot.call_deferred("remove_child", level)
	level.level_finished.disconnect(handle_next_level)
	level.level_failed.disconnect(handle_level_failure)


func setup_level(scene:PackedScene, isPractice: bool = false) -> Level:
	var level = scene.instantiate()
	levelRoot.call_deferred("add_child",level)
	level.set_deferred("isPractice", isPractice)
	level.level_finished.connect(handle_next_level)
	level.level_failed.connect(handle_level_failure)
	level.visible = true
	return level


func practice_unlock_check(id: int) -> void:
	if id > highestLevelId:
		highestLevelId = id
		practiceMenu.enable_practice_level(id)


func stage_unlock_check(id: int) -> void:
	var stageCheck: int = ceil(id as float / 4.0)
	if stageCheck > highestStage:
		highestStage = stageCheck
		playMenu.enable_stage(stageCheck)
