extends Node

signal respawn

func _ready():
	pass

func respawn():
	emit_signal("respawn")