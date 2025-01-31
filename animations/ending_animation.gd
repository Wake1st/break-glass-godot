class_name EndingAnimation
extends Node2D

@onready var stageTimer = $StageTimer
@onready var audio = $AudioStreamPlayer
@onready var end = $End

var stage: int = 0


var play:bool = true
func _process(delta):
	if play:
		play = false
		run()


func run() -> void:
	end.visible = false
	visible = true
	run_stage()


func run_stage() -> void:
	# run the stage
	match stage:
		0: stage_0()
		1: stage_1()
		2: stage_2()
	
	# itterate for next stage
	stage += 1


func _on_stage_timer_timeout():
	run_stage()


func stage_0() -> void:
	stageTimer.start(0.8)


func stage_1() -> void:
	audio.play()
	stageTimer.start(10)


func stage_2() -> void:
	end.visible = true
