class_name IntroAnimation
extends Node2D

signal finished()

const ANNOUNCER_READY: AudioStreamMP3 = preload("res://assets/voice/announcer - ready.mp3")
const ANNOUNCER_QUESTION: AudioStreamMP3 = preload("res://assets/voice/announcer - question.mp3")
const ANNOUNCER_WHAT: AudioStreamMP3 = preload("res://assets/voice/announcer - what.mp3")
const CROWD_CHEER_SECOND: AudioStreamMP3 = preload("res://assets/sfx/crowd cheer 1.mp3")
const CROWD_CHEER_FIRST: AudioStreamMP3 = preload("res://assets/sfx/crowd cheer 2.mp3")
const CROWD_CHANT: AudioStreamMP3 = preload("res://assets/sfx/crowd chant.mp3")

@onready var stageTimer: Timer = $StageTimer
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var announcerAudio: AudioStreamPlayer = $AnnouncerAudio
@onready var crowdAudio: AudioStreamPlayer = $CrowdAudio

@onready var announcer: Sprite2D = $Announcer
@onready var crowd: Sprite2D = $Crowd

var stage: int = 0


func run() -> void:
	announcer.visible = false
	crowd.visible = false
	visible = true
	run_stage()


func run_stage() -> void:
	# run the stage
	match stage:
		0: stage_0()
		1: stage_1()
		2: stage_2()
		3: stage_3()
		4: stage_4()
		5: stage_5()
		6: stage_6()
		7: stage_7()
	
	# itterate for next stage
	stage += 1


func _on_stage_timer_timeout():
	run_stage()


func stage_0() -> void:
	stageTimer.start(0.8)


func stage_1() -> void:
	animation.play("announcer - ready")
	announcerAudio.stream = ANNOUNCER_READY
	announcerAudio.play()
	stageTimer.start(4.4)


func stage_2() -> void:
	animation.play("crowd - cheer first")
	crowdAudio.stream = CROWD_CHEER_FIRST
	crowdAudio.play()
	stageTimer.start(3.6)


func stage_3() -> void:
	animation.play("announcer - question")
	announcerAudio.stream = ANNOUNCER_QUESTION
	announcerAudio.play()
	stageTimer.start(4.8)


func stage_4() -> void:
	animation.play("crowd - cheer second")
	crowdAudio.volume_db = linear_to_db(1.4)
	crowdAudio.stream = CROWD_CHEER_SECOND
	crowdAudio.play()
	stageTimer.start(2.6)


func stage_5() -> void:
	animation.play("announcer - what")
	announcerAudio.stream = ANNOUNCER_WHAT
	announcerAudio.play()
	stageTimer.start(2.0)


func stage_6() -> void:
	animation.play("crowd - chant")
	crowdAudio.volume_db = linear_to_db(1.8)
	crowdAudio.stream = CROWD_CHANT
	crowdAudio.play()
	stageTimer.start(3.4)


func stage_7() -> void:
	visible = false
	finished.emit()
