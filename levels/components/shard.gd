@tool

class_name Shard
extends RigidBody2D

const MASS_COEFFICIENT: float = 480
const HEIGHT: int = 16

@onready var image: Sprite2D = $Image
@onready var collision: CollisionShape2D = $Collision


func set_piece(pos: Vector2, vel: Vector2) -> void:
	# first, ensure the children are setup
	if image == null:
		image = get_node("Image")
	if collision == null:
		collision = get_node("Collision")
	
	# generate an index for the piece
	var index = randi_range(0, 7)
	
	# set image
	image.frame = index
	
	# set mass
	var value: int = ShardMass.values[index]
	mass = value / MASS_COEFFICIENT
	
	# set shape
	var new_shape = RectangleShape2D.new()
	new_shape.size = Vector2(value/HEIGHT, HEIGHT)
	collision.set_deferred("shape", new_shape)
	
	# set translation values
	position += pos
	linear_velocity = vel
