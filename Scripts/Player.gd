extends CharacterBody3D

const SPEED = 15.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_pivot = $CameraPivot;

func _process(_delta : float) -> void:
	camera_pivot.position = position;

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	if not WorldGlobals.timeIsOut:
		_movement(delta);

func _movement(_delta: float) -> void:
	if not WorldGlobals.gameIsStop:
		var input_dir := Input.get_vector("move_left","move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		direction = direction.rotated(Vector3.UP, camera_pivot.rotation.y).normalized();
		if direction:
			velocity.x = direction.x * SPEED;
			velocity.z = direction.z * SPEED;
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED);
			velocity.z = move_toward(velocity.z, 0, SPEED);

		move_and_slide()
