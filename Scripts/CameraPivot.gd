extends SpringArm3D

@onready var camera = $Camera3D;

func _ready():
	# this is necessary, otherwise the camera will move 
	set_as_top_level(true);

func _process(delta):
	if not WorldGlobals.timeIsOut:
		_camera_movement();
	else:
		game_stop_camera();
		
func _camera_movement() -> void:
	if Input.is_action_pressed("camera_backward") and spring_length < 10:
		spring_length += 0.1;
	if Input.is_action_pressed("camera_forward") and spring_length > 2:
		spring_length -= 0.1;
	
	var rotation_y = Input.get_axis("camera_left","camera_right");
	if rotation_y != 0:
		rotation_degrees.y += rotation_y;
		rotation_degrees.y = wrap(rotation_degrees.y, 0.0, 360.0);
		
	var rotation_x = Input.get_axis("camera_down","camera_up");
	if rotation_x != 0:
		rotation_degrees.x += rotation_x;
		rotation_degrees.x = clamp(rotation_degrees.x, -45.0, 0.0);

func game_stop_camera() -> void:
	rotation_degrees.y = wrap(rotation_degrees.y + 1.0, 0.0, 360.0);
