class_name Player
extends CharacterBody2D

const GRAVITY: float = 9.0
const IMPULSE_BOOST: float = 120.0
const ANIMATION_ANGLE: float = PI/4

@onready var aim: Aim = $Aim
@onready var image: Sprite2D = $Image
@onready var imageAnimator: AnimationPlayer = $Image/AnimationPlayer


var isAiming: bool = false
var headFirst: bool = false
var surfaceForward: float = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flip"):
		flip(!headFirst)


func _physics_process(delta):
	# ensure player "sticks" to surface
	if is_on_floor() or is_on_wall() or is_on_ceiling():
		# set velocity
		velocity = Vector2.ZERO

		# face the player UP with the surface normal
		image.rotation = surfaceForward

		# animate
		imageAnimator.play("idle")
	else:
		# update motion
		velocity.y += GRAVITY
		
		# face the player according to the motion
		if headFirst:
			image.look_at(global_position + velocity)
		else:
			image.look_at(global_position - velocity)
		image.rotate(ANIMATION_ANGLE)

		# animate
		imageAnimator.play("flying")

	# update aiming
	if Input.is_action_just_released("aim"):
		isAiming = false
		aim.visible = false
		
		velocity += aim.launch() * IMPULSE_BOOST
		flip(true)
	if Input.is_action_just_pressed("aim"):
		isAiming = true
		aim.visible = true
	
	if isAiming:
		#	send the new direction
		aim.update(delta, get_global_mouse_position())
	
	move_and_slide()


func flip(value: bool) -> void:
	headFirst = value
	set_collision_layer_value(2, !headFirst)
	set_collision_mask_value(2, !headFirst)
