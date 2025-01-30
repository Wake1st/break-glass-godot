class_name PlayStage
extends Button

@export var stageName: String:
	set(value):
		(get_node("%Title") as Label).text = "%s Stage" % value
