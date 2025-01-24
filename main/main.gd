class_name Main
extends Node

@onready var mainMenu: MainMenu = %MainMenu
@onready var playMenu: PlayMenu = %PlayMenu
@onready var practiceMenu: PracticeMenu = %PracticeMenu
@onready var settingsMenu: SettingsMenu = %SettingsMenu

@onready var resultMenu: ResultMenu = %ResultMenu
@onready var failureMenu: FailureMenu = %FailureMenu
@onready var practiceLevelMenu: PracticeLevelMenu = %PracticeLevelMenu

@onready var levelRoot: Node2D = $LevelRoot

var currentMenu: Panel
var currentLevel: Level
var levelList: LevelList = LevelList.new()
var isPractice: bool

var currentLevelId: int = 1
var currentStageId: int = 1
var highestLevelId: int = 1
var highestStageId: int = 1


func _ready() -> void:
	# first, pause the game
	get_tree().paused = true
	
	# menu setup
	currentMenu = mainMenu
	
	mainMenu.menu_selected.connect(handle_menu_change)
	playMenu.level_selected.connect(handle_level_select)
	playMenu.return_selected.connect(handle_return_to_main)
	practiceMenu.return_selected.connect(handle_return_to_main)
	settingsMenu.return_selected.connect(handle_return_to_main)
	practiceMenu.practice_level_selected.connect(handle_practice_level_select)
	
	resultMenu.menu_selected.connect(handle_menu_selected)
	resultMenu.next_selected.connect(handle_next_selected)
	failureMenu.menu_selected.connect(handle_menu_selected)
	failureMenu.reset_selected.connect(handle_reset_selected)
	practiceLevelMenu.menu_selected.connect(handle_menu_selected)
	#practiceLevelMenu.prev_selected.connect()
	#practiceLevelMenu.replay_selected.connect()
	#practiceLevelMenu.next_selected.connect()
	
	# unlock the first level for practice
	practice_unlock_check(1)


#region Main UI Handlers

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
		disconnect_level()
	
	# swap levels
	setup_level(scene)
	
	# disable the current menu
	currentMenu.visible = false


func handle_practice_level_select(scene:PackedScene) -> void:
	if currentLevel != null:
		disconnect_level()
	
	# swap levels
	setup_level(scene, true)
	practiceLevelMenu.visible = true
	
	# disable the current menu
	currentMenu.visible = false

#endregion


func handle_exit_level() -> void:
	disconnect_level()
	
	if isPractice:
		practiceMenu.visible = true
	else:
		playMenu.visible = true


func handle_level_failed() -> void:
	if isPractice:
		practiceLevelMenu.visible = true
	else:
		failureMenu.visible = true


func handle_level_finished(id: int) -> void:
	currentLevelId = id
	
	if isPractice:
		practiceLevelMenu.visible = true
	else:
		resultMenu.visible = true


func handle_reset_stage() -> void:
	disconnect_level()
	
	# reset at the beginning of the stage
	var levelId = currentStageId * 4 - 3
	var scene = levelList.levels[levelId]
	setup_level(scene)


func handle_next_level(levelId: int) -> void:
	var nextLevelId = levelId + 1
	currentLevelId = nextLevelId
	
	# disconnect current level
	disconnect_level()
	
	# setup new level
	var scene = levelList.levels[nextLevelId]
	setup_level(scene)
	
	# set the highest level for training
	practice_unlock_check(nextLevelId)
	
	# every 4th level should unlock the next stage
	stage_unlock_check(nextLevelId)


func handle_next_selected() -> void:
	resultMenu.visible = false


func handle_reset_selected() -> void:
	failureMenu.visible = false


func handle_menu_selected() -> void:
	resultMenu.visible = false
	failureMenu.visible = false


func handle_next_practice_level() -> void:
	var nextLevelId = currentLevelId + 1
	
	# disconnect current level
	disconnect_level()
	
	# setup new level
	var scene = levelList.levels[nextLevelId]
	setup_level(scene)


func handle_prev_practice_level() -> void:
	var nextLevelId = currentLevelId - 1
	
	# disconnect current level
	disconnect_level()
	
	# setup new level
	var scene = levelList.levels[nextLevelId]
	setup_level(scene)


func disconnect_level() -> void:
	currentLevel.visible = false
	levelRoot.call_deferred("remove_child", currentLevel)
	currentLevel.level_finished.disconnect(handle_level_finished)
	currentLevel.level_failed.disconnect(handle_reset_stage)
	currentLevel.level_quit.disconnect(handle_exit_level)
	currentLevel = null


func setup_level(scene: PackedScene, isPractice: bool = false) -> void:
	var level = scene.instantiate()
	level.isPractice = isPractice
	levelRoot.call_deferred("add_child",level)
	level.level_finished.connect(handle_level_finished)
	level.level_failed.connect(handle_reset_stage)
	level.level_quit.connect(handle_exit_level)
	level.visible = true
	currentLevel = level


func practice_unlock_check(id: int) -> void:
	if id > highestLevelId:
		highestLevelId = id
		practiceMenu.enable_practice_level(id)


func stage_unlock_check(id: int) -> void:
	var stageCheck: int = ceil(id as float / 4.0)
	currentStageId = stageCheck
	if stageCheck > highestStageId:
		highestStageId = stageCheck
		playMenu.enable_stage(stageCheck)
