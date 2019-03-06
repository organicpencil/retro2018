extends Control

func _ready():
	Global.connect("respawn", self, "_handle_respawn")
	$ColorRect.show()
	$ColorRect/AnimationPlayer.play("respawn")

func _handle_respawn():
	$ColorRect/AnimationPlayer.play("respawn")

func _process(delta):
	$SpeedLabel.text = "%.0f" % Global.speed