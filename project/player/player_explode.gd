extends Spatial

var linear_impulse
var angular_impulse

func _ready():
	assert(linear_impulse != null and angular_impulse != null)
	yield(get_tree(), "physics_frame")
	var parent = get_parent()
	for c in get_children():
		if c is RigidBody:
			var trans = c.global_transform
			remove_child(c)
			parent.add_child(c)
			c.apply_central_impulse(linear_impulse)
			c.apply_torque_impulse(angular_impulse)
			c.global_transform = trans

	queue_free()