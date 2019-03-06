extends Node

enum {GAME_RUNNING, GAME_WON, GAME_LOST}

var game_state = GAME_RUNNING
var speed = 0.0
var lives = 5

signal respawn
signal win
signal lose

func _ready():
	pass

func respawn():
	if game_state != GAME_RUNNING:
		return

	if lives == 0:
		lose()
		return

	lives -= 1
	emit_signal("respawn")

func win():
	if game_state != GAME_RUNNING:
		return

	game_state = GAME_WON
	emit_signal("win")

func lose():
	if game_state != GAME_RUNNING:
		return

	game_state = GAME_LOST
	emit_signal("lose")