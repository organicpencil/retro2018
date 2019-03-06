extends Control

func _ready():
	Global.connect("respawn", self, "_handle_respawn")
	$ColorRect.show()
	_handle_respawn()

	Global.connect("win", self, "_handle_win")
	Global.connect("lose", self, "_handle_lose")

func _handle_respawn():
	$ColorRect/AnimationPlayer.play("respawn")
	$Lives.text = "Sweet rides: %d" % Global.lives

func _handle_win():
	$Status.text = "winnar"

func _handle_lose():
	$Status.text = "lews"

func _process(delta):
	$Speed.text = "%.0f" % Global.speed