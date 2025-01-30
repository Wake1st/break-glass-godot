class_name PracticeAnimation
extends Node2D

signal finished()

const COACH_INTRO: AudioStreamMP3 = preload("res://assets/voice/coach - intro.mp3")
const COACH_EXPLANATION: AudioStreamMP3 = preload("res://assets/voice/coach - explanation.mp3")
const COACH_EYES: AudioStreamMP3 = preload("res://assets/voice/coach - eyes.mp3")
const TERRY_1: AudioStreamWAV = preload("res://assets/sfx/AMBIENCE_UNDERGROUND_POWER_STATION_LOOP.wav")
const TERRY_2: AudioStreamWAV = preload("res://assets/sfx/AMBIENCE_SPACECRAFT_HOLD_LOOP.wav")

@onready var stageTimer = $StageTimer
@onready var coachAnimator = $CoachAnimator
@onready var terryAnimator = $TerryAnimator
@onready var transformAnimator = $TransformAnimator

@onready var coachAudio = $CoachAudio
@onready var terryAudio = $TerryAudio

@onready var coach = $Coach
@onready var terry = $Terry

var stage: int = 0
var terryTween: Tween


func run() -> void:
	visible = true
	run_stage()


func run_stage() -> void:
	# run the stage
	print("stage: %s" % stage)
	match stage:
		0: stage_0()
		1: stage_1()
		2: stage_2()
		3: stage_3()
		4: stage_4()
		5: stage_5()
		6: stage_6()
		7: stage_7()
		8: stage_8()
		9: stage_9()
	
	# itterate for next stage
	stage += 1


func _on_stage_timer_timeout():
	run_stage()


func stage_0() -> void:
	stageTimer.start(0.1)


func stage_1() -> void:
	coach.visible = true
	terry.visible = true
	coachAnimator.play("coach")
	coachAudio.stream = COACH_INTRO
	coachAudio.play()
	stageTimer.start(4.8)


func stage_2() -> void:
	transformAnimator.play("terry_1")
	stageTimer.start(2.0)


func stage_3() -> void:
	terryAnimator.play("terry")
	terryAudio.stream = TERRY_1
	terryAudio.volume_db = -60
	terryAudio.play()
	terryTween = create_tween()
	terryTween.tween_property(terryAudio, "volume_db", linear_to_db(1), 5.0)
	terryTween.set_ease(Tween.EASE_IN)
	stageTimer.start(5.0)


func stage_4() -> void:
	terryAnimator.play("RESET")
	terryAudio.stop()
	coachAudio.stream = COACH_EXPLANATION
	coachAudio.play()
	stageTimer.start(3.2)


func stage_5() -> void:
	transformAnimator.play("terry_2")
	stageTimer.start(30.8)


func stage_6() -> void:
	terry.frame = 1
	transformAnimator.play("terry_3")
	terryAudio.volume_db = linear_to_db(.1)
	terryAudio.stream = TERRY_2
	terryAudio.play()
	terryTween = create_tween()
	terryTween.tween_property(terryAudio, "volume_db", linear_to_db(2.2), 10.4)
	terryTween.set_ease(Tween.EASE_IN_OUT)
	stageTimer.start(4.8)


func stage_7() -> void:
	coachAudio.stream = COACH_EYES
	coachAudio.play()
	stageTimer.start(5.6)


func stage_8() -> void:
	terryAudio.stop()
	stageTimer.start(7.4)


func stage_9() -> void:
	visible = false
	finished.emit()
