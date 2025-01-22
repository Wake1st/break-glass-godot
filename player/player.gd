class_name Player
extends CharacterBody2D


var isAiming: bool = false


func _physics_process(delta):
	if Input.is_action_just_pressed("aiming"):
		isAiming = false
	if Input.is_action_just_pressed("aiming"):
		isAiming = true
