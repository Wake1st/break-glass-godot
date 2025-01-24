class_name Main
extends Node


enum MENUS {
	MAIN,
	PLAY,
	PRACTICE,
	SETTINGS,
	RESULT,
	FAILURE,
	PRACTICE_RESULT
}


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
var highestLevelId: int = 0
var highestStageId: int = 0

func _ready() -> void:
	# first, pause the game
	get_tree().paused = true
	
	# menu setup
	currentMenu = mainMenu
	
	mainMenu.menu_selected.connect(handle_menu_change)
	settingsMenu.menu_selected.connect(handle_menu_change)
	playMenu.level_selected.connect(handle_level_select)
	playMenu.menu_selected.connect(handle_menu_change)
	practiceMenu.menu_selected.connect(handle_menu_change)
	practiceMenu.practice_level_selected.connect(handle_practice_level_select)
	
	failureMenu.menu_selected.connect(handle_return_to_menu)
	failureMenu.reset_selected.connect(handle_reset_stage)
	resultMenu.menu_selected.connect(handle_return_to_menu)
	resultMenu.next_selected.connect(handle_next_level)
	practiceLevelMenu.menu_selected.connect(handle_return_to_menu)
	practiceLevelMenu.prev_selected.connect(handle_prev_practice_level)
	practiceLevelMenu.replay_selected.connect(handle_replay_practice_level)
	practiceLevelMenu.next_selected.connect(handle_next_practice_level)
	
	# unlock the first level for practice
	practice_unlock_check(1)


#region UI Navigation

func handle_menu_change(menu: MENUS) -> void:
	currentMenu.visible = false
	
	# make menu visible
	match menu:
		MENUS.MAIN: currentMenu = mainMenu
		MENUS.PLAY: currentMenu = playMenu
		MENUS.PRACTICE: currentMenu = practiceMenu
		MENUS.SETTINGS: currentMenu = settingsMenu
		MENUS.RESULT: currentMenu = resultMenu
		MENUS.FAILURE: currentMenu = failureMenu
		MENUS.PRACTICE_RESULT: currentMenu = practiceLevelMenu
	
	currentMenu.visible = true


func handle_menu_selected() -> void:
	if isPractice:
		handle_menu_change(MENUS.PRACTICE)
	else:
		handle_menu_change(MENUS.PLAY)


func handle_level_failed() -> void:
	if isPractice:
		handle_menu_change(MENUS.PRACTICE_RESULT)
	else:
		handle_menu_change(MENUS.FAILURE)


func handle_level_finished() -> void:
	if isPractice:
		handle_menu_change(MENUS.PRACTICE_RESULT)
	else:
		handle_menu_change(MENUS.RESULT)

#endregion

#region Level Navigation

func handle_level_select(scene: PackedScene) -> void:
	# disconnect current level
	if currentLevel != null:
		disconnect_level()
	
	# swap levels
	isPractice = false
	setup_level(scene)
	
	# disable the current menu
	currentMenu.visible = false


func handle_practice_level_select(scene:PackedScene) -> void:
	# disconnect current level
	if currentLevel != null:
		disconnect_level()
	
	# swap levels
	isPractice = true
	setup_level(scene)
	
	# disable the current menu
	currentMenu.visible = false


func handle_return_to_menu() -> void:
	# disconnect current level
	disconnect_level()
	
	if isPractice:
		handle_menu_change(MENUS.PRACTICE)
	else:
		handle_menu_change(MENUS.PLAY)


func handle_reset_stage() -> void:
	disconnect_level()
	
	# reset at the beginning of the stage
	var levelId = currentStageId * 4 - 3
	var scene = levelList.levels[levelId]
	setup_level(scene)
		
	# disable the current menu
	currentMenu.visible = false


func handle_next_level() -> void:
	# disconnect current level
	disconnect_level()

	print("prev: %s" % currentLevelId)
	currentLevelId += 1
	print("next: %s" % currentLevelId)
	
	# setup new level
	var scene = levelList.levels[currentLevelId]
	setup_level(scene)
	
	# set the highest level for training
	practice_unlock_check(currentLevelId)
	
	# every 4th level should unlock the next stage
	stage_unlock_check(currentLevelId)
		
	# disable the current menu
	currentMenu.visible = false


func handle_prev_practice_level() -> void:
	# disconnect current level
	disconnect_level()

	currentLevelId -= 1
	
	# setup new level
	var scene = levelList.levels[currentLevelId]
	setup_level(scene)
		
	# disable the current menu
	currentMenu.visible = false


func handle_replay_practice_level() -> void:
	# disconnect current level
	disconnect_level()
	
	# setup new level
	var scene = levelList.levels[currentLevelId]
	setup_level(scene)
		
	# disable the current menu
	currentMenu.visible = false


func handle_next_practice_level() -> void:
	# disconnect current level
	disconnect_level()
	
	currentLevelId += 1
	
	# setup new level
	var scene = levelList.levels[currentLevelId]
	isPractice = true
	setup_level(scene)
		
	# disable the current menu
	currentMenu.visible = false

#endregion

#region Helpers

func disconnect_level() -> void:
	currentLevel.visible = false
	levelRoot.call_deferred("remove_child", currentLevel)
	currentLevel.level_finished.disconnect(handle_level_finished)
	currentLevel.level_failed.disconnect(handle_level_failed)
	currentLevel = null


func setup_level(scene: PackedScene) -> void:
	var level = scene.instantiate()
	levelRoot.call_deferred("add_child",level)
	level.level_finished.connect(handle_level_finished)
	level.level_failed.connect(handle_level_failed)
	level.isPractice = isPractice
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

#endregion
