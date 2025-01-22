class_name Player
extends CharacterBody2D

const GRAVITY = 9.0
const IMPULSE_BOOST = 90.0

@onready var aim: Aim = $Aim
@onready var image: Sprite2D = $Image
@onready var imageAnimator: AnimationPlayer = $Image/AnimationPlayer

var isAiming: bool = false
var headFirst: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flip"):
		headFirst = !headFirst


func _physics_process(delta):
	# ensure no sliding occurs
	if is_on_floor():
		velocity = Vector2.ZERO

		imageAnimator.play("idle")
	else:
		imageAnimator.play("flying")

	# update aiming
	if Input.is_action_just_released("aim"):
		isAiming = false
		aim.visible = false
		
		velocity += aim.launch() * IMPULSE_BOOST
	if Input.is_action_just_pressed("aim"):
		isAiming = true
		aim.visible = true
	
	if isAiming:
		#	send the new direction
		aim.update(delta, get_global_mouse_position())
	
	# update motion
	velocity.y += GRAVITY
	
	move_and_slide()
