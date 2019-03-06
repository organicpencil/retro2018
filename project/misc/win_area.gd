extends Area

func _ready():
	connect("body_entered", self, "_handle_body_entered")

func _handle_body_entered(body):
	if body.has_meta("player"):
		Global.win()