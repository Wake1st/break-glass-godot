@tool
class_name ResultContainer
extends PanelContainer

@export var label: String:
	set(value):
		label = value
		if has_node("%Name"):
			(get_node("%Name") as Label).text = value

@onready var valueLabel: Label = %Value


func set_value(value: float) -> void:
	valueLabel.text = String.num(value, 2)
