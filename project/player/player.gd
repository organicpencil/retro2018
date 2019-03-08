extends VehicleBody

const STEER = 0.5
const STEER_WEIGHT = 0.15
const ANGLE_MAX = 20.0 # Degrees

const PlayerExplode = preload("res://player/player_explode.tscn")

# Stores the last xx seconds of positions, respawn at [0] when you hit something
var transforms = []
const TRANSFORM_SAMPLE_INTERVAL = 1.0
const TRANSFORM_SAMPLE_LIMIT = 2

export(NodePath) var win_area
var start_dist = 0.0

func _ready():
	assert(win_area != null)
	win_area = get_node(win_area)

	set_meta("player", true)
	connect("body_entered", self, "_handle_body_entered")
	Global.connect("lose", self, "_handle_lose")

	transforms = [Transform(global_transform.basis, global_transform.origin)]
	var transform_sampler = Timer.new()
	transform_sampler.one_shot = false
	transform_sampler.wait_time = TRANSFORM_SAMPLE_INTERVAL
	transform_sampler.connect("timeout", self, "_sample_position")
	add_child(transform_sampler)
	transform_sampler.start()

	# Used to calculate completion progress
	start_dist = global_transform.origin.distance_to(win_area.global_transform.origin)

func _handle_body_entered(body):
	if body.has_meta("obstacle"):
		# Explode
		var explode = PlayerExplode.instance()
		explode.transform = transform
		explode.linear_impulse = linear_velocity * 2
		explode.angular_impulse = angular_velocity * 2
		get_parent().add_child(explode)

		# Respawn a ways back
		global_transform = transforms[0]
		linear_velocity = Vector3()
		angular_velocity = Vector3()

		# Trigger hud and other logic
		Global.respawn()

func _handle_lose():
	queue_free()

func _sample_position():
	transforms.push_back(Transform(global_transform.basis, global_transform.origin))
	if transforms.size() > TRANSFORM_SAMPLE_LIMIT:
		transforms.pop_front()

func _physics_process(delta):
	Global.speed = abs(global_transform.basis.xform_inv(linear_velocity)[2])

	var steer = 0.0
	if Input.is_action_pressed("left"):
		steer += 1.0
	if Input.is_action_pressed("right"):
		steer -= 1.0

	var rot = rotation.y

	if steer == 0.0:
		steer = clamp(-rot, -STEER, STEER)

	# Prevent going sideways/backwards
	if rot > deg2rad(ANGLE_MAX):
		steer = clamp(steer, -1, 0)
	elif rot < -deg2rad(ANGLE_MAX):
		steer = clamp(steer, 0, 1)

	steering = lerp(steering, steer * STEER, STEER_WEIGHT)

	engine_force = 150.0

	# Update distance to win
	if global_transform.origin.z < win_area.global_transform.origin.z:
		Global.progress = 100
	else:
		var dist = global_transform.origin.distance_to(win_area.global_transform.origin)
		Global.progress = int((1.0 - min(dist / start_dist, 1.0)) * 100)