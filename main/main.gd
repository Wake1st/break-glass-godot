extends Node

@onready var mainMenu: MainMenu = %MainMenu
@onready var playMenu: PlayMenu = %PlayMenu
@onready var practiceMenu: PracticeMenu = %PracticeMenu
@onready var settingsMenu: SettingsMenu = %SettingsMenu
@onready var levelRoot = $LevelRoot

var currentMenu:Panel
var currentLevel:Level


func _ready() -> void:
	# connect menu signals
	currentMenu = mainMenu
	mainMenu.menu_selected.connect(handle_menu_change)
	playMenu.return_selected.connect(handle_return_to_main)
	practiceMenu.return_selected.connect(handle_return_to_main)
	settingsMenu.return_selected.connect(handle_return_to_main)

	# connect level signals
	# currentLevel = levelRoot.get_child(0)


func handle_menu_change(sceneName: String) -> void:
	currentMenu.visible = false

	match sceneName:
		"play": currentMenu = playMenu
		"practice": currentMenu = practiceMenu
		"settings": currentMenu = settingsMenu
	
	currentMenu.visible = true


func handle_return_to_main() -> void:
	currentMenu.visible = false
	currentMenu = mainMenu
	currentMenu.visible = true