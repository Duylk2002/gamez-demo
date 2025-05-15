extends CharacterBody3D

@export var speed = 15.0;
@export var rotation_speed = 2 * PI;

@onready var ship_body: Node3D = $ShipBody;

var tilt_angle: float = 0.0
var tilt_speed: float = 1.5  # radians per second
var max_tilt: float = 0.5    # about 30 degrees
var move_speed: float = 10.0

func _physics_process(delta: float) -> void:
	# Handle tilting (W/S)
	if Input.is_action_pressed("ui_up"):
		tilt_angle = clamp(tilt_angle + tilt_speed * delta, -max_tilt, max_tilt)
	elif Input.is_action_pressed("ui_down"):
		tilt_angle = clamp(tilt_angle - tilt_speed * delta, -max_tilt, max_tilt)
	else:
		# Return to neutral tilt when no input
		tilt_angle = lerp(tilt_angle, 0.0, 0.1)

	# Apply tilt to the ship (pitch)
	rotation.z = tilt_angle

	# Handle sideways movement (A/D)
	var move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if move_input != 0:
		velocity = transform.basis.x * move_speed * move_input
	else:
		velocity = Vector3.ZERO	
	move_and_slide()
