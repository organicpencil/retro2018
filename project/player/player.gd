extends VehicleBody

const STEER = 0.5
const STEER_WEIGHT = 0.15
const ANGLE_MAX = 20.0 # Degrees

func _physics_process(delta):
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