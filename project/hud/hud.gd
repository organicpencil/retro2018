extends Control

func _ready():
	Global.connect("respawn", self, "_handle_respawn")
	$ColorRect.show()
	_handle_respawn()

	Global.connect("win", self, "_handle_win")
	Global.connect("lose", self, "_handle_lose")

func _handle_respawn():
	$ColorRect/AnimationPlayer.play("respawn")
	if Global.lives == 4:
		$Lives/life5.modulate = Color(1,0,0)
	if Global.lives == 3:
		$Lives/life4.modulate = Color(1,0,0)
	if Global.lives == 2:
		$Lives/life3.modulate = Color(1,0,0)
	if Global.lives == 1:
		$Lives/life2.modulate = Color(1,0,0)
	if Global.lives == 0:
		$Lives/life1.modulate = Color(1,0,0)



func _handle_win():
	$Status.text = "winnar"

func _handle_lose():
	$Status.text = "PROGRAM OVERWRITE-GAME OVER"

func _process(delta):
	$TextureProgress/Speed.text = "%.0f" % Global.speed
	$TextureProgress/speedometer/pointer.rect_rotation = Global.speed - 90
	if Global.speed - 90 >= 90:
		$TextureProgress/speedometer/pointer.rect_rotation = 90

	$TextureProgress.value = Global.progress
	$TextureProgress/Label.text = "SAVING... %d%%" % Global.progress
