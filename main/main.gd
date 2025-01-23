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

var highestLevelId: int = 1
var highestStage: int = 1


func _ready() -> void:
	# menu setup
	currentMenu = mainMenu
	
	mainMenu.menu_selected.connect(handle_menu_change)
	playMenu.return_selected.connect(handle_return_to_main)
	practiceMenu.return_selected.connect(handle_return_to_main)
	settingsMenu.return_selected.connect(handle_return_to_main)

	playMenu.level_selected.connect(handle_level_select)


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

	currentLevel.visible = true
	
	# disable the current menu
	currentMenu.visible = false


func handle_level_failure() -> void:
	disconnect_level(currentLevel)
	handle_return_to_main()


func handle_next_level(levelId) -> void:
	nextLevelId = levelId
	endLevelTimer.start()
	
	# set the highest level for training
	if levelId > highestLevelId:
		highestLevelId = levelId 

	# every 4th level should unlock the next stage
	var stageCheck: int = ceil(levelId as float / 4.0)
	if stageCheck > highestStage:
		highestStage = stageCheck
		playMenu.enable_stage(stageCheck)


func _on_end_timer_timeout() -> void:
	# disconnect current level
	disconnect_level(currentLevel)

	# setup new level
	var scene = levelList.levels[nextLevelId]
	currentLevel = setup_level(scene)
	
	currentLevel.visible = true


func disconnect_level(level:Level) -> void:
	level.visible = false
	levelRoot.call_deferred("remove_child", level)
	level.level_finished.disconnect(handle_next_level)
	level.level_failed.disconnect(handle_level_failure)


func setup_level(scene:PackedScene) -> Level:
	var level = scene.instantiate()
	levelRoot.call_deferred("add_child",level)
	level.level_finished.connect(handle_next_level)
	level.level_failed.connect(handle_level_failure)
	level.visible = true
	return level
