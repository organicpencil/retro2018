extends Node

var speed = 0.0
signal respawn

func _ready():
	pass

func respawn():
	emit_signal("respawn")