class_name LevelSFX
extends Node

const FAILURE: AudioStreamMP3 = preload("res://assets/sfx/announcer - failure.mp3")
const FINISHED: AudioStreamMP3 = preload("res://assets/sfx/announcer - finished.mp3")
const CROWD_BOO: AudioStreamMP3 = preload("res://assets/sfx/crowd boo.mp3")
const CROWD_CHEER_1: AudioStreamMP3 = preload("res://assets/sfx/crowd cheer 1.mp3")
const CROWD_CHEER_2: AudioStreamMP3 = preload("res://assets/sfx/crowd cheer 2.mp3")

@onready var announcer = $Announcer
@onready var crowd = $Crowd


func play_success() -> void:
	announcer.stream = FINISHED
	announcer.play()
	
	crowd.stream = CROWD_BOO
	crowd.play()


func play_failure() -> void:
	announcer.stream = FAILURE
	announcer.play()
	
	if randi() % 2 == 1:
		crowd.stream = CROWD_CHEER_1
	else:
		crowd.stream = CROWD_CHEER_2
	crowd.play()
