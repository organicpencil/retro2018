extends Camera

export(NodePath) var player
export var offset = Vector3(0, 5, 10)

func _ready():
	player = weakref(get_node(player))

func _process(delta):
	var p = player.get_ref()
	if p:
		translation = p.translation + offset
		look_at(p.translation, Vector3(0, 1, 0))