# the code here is heavily inspired by GDQuest - 3D Movement in Godot in Only 6 Minutes (https://www.youtube.com/watch?v=UpF7wm0186Q)
extends SpringArm3D;

@onready var camera := $Camera3D;

## Mouse variables
@export var mouse_sensibility := 0.05;
@export var invert_wheel_movement := false;
@export var invert_camera_movement := false;
@export_range(1,10,1) var wheel_sensibility := 1;

func _ready() -> void:
	# this is necessary, otherwise the camera will move 
	set_as_top_level(true);
	invert_wheel_movement = globals.is_scroll_inverted;
	invert_camera_movement = globals.is_camera_inverted;
	events.connect("invert_scroll", _on_scroll_inverted);
	events.connect("invert_camera", _on_camera_inverted);

func _process(_delta: float) -> void:
	if (not globals.time_is_out and not globals.game_is_stop):
		_camera_movement();
	else:
		game_stop_camera();
		
func _on_scroll_inverted(is_inverted: bool) -> void:
	invert_wheel_movement = is_inverted;

func _on_camera_inverted(is_inverted: bool) -> void:
	invert_camera_movement = is_inverted;

func _unhandled_input(event: InputEvent) -> void:
	if (not globals.game_is_stop):
		if (event is InputEventMouseMotion):
			rotation_degrees.y -= event.relative.x * mouse_sensibility if (not invert_camera_movement) else event.relative.x * mouse_sensibility * -1;
			rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0);
			
			rotation_degrees.x -= event.relative.y * mouse_sensibility if (not invert_camera_movement) else event.relative.y * mouse_sensibility * -1;
			rotation_degrees.x = clamp(rotation_degrees.x, -45.0, 0.0);
		if (event is InputEventMouseButton):
			if (event.button_index == MOUSE_BUTTON_WHEEL_UP):
				if (invert_wheel_movement and spring_length > 2):
					spring_length -= 0.1 * wheel_sensibility;
				elif (spring_length < 10):
					spring_length += 0.1 * wheel_sensibility;
			if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
				if (invert_wheel_movement and spring_length < 10):
					spring_length += 0.1 * wheel_sensibility;
				elif  (spring_length > 2):
					spring_length -= 0.1 * wheel_sensibility;
	
func _camera_movement() -> void:
	if (Input.is_action_pressed("camera_backward") and spring_length < 10):
		spring_length += 0.1;
	if (Input.is_action_pressed("camera_forward") and spring_length > 2):
		spring_length -= 0.1;
	
	var rotation_y := Input.get_axis("camera_left","camera_right");
	if (rotation_y != 0):
		rotation_degrees.y += rotation_y if (not invert_camera_movement) else rotation_y * -1;
		rotation_degrees.y = wrap(rotation_degrees.y, 0.0, 360.0);
		
	var rotation_x := Input.get_axis("camera_down","camera_up");
	if (rotation_x != 0):
		rotation_degrees.x += rotation_x if (not invert_camera_movement) else rotation_x * -1;
		rotation_degrees.x = clamp(rotation_degrees.x, -45.0, 0.0);

func game_stop_camera() -> void:
	rotation_degrees.y = wrap(rotation_degrees.y + 1.0, 0.0, 360.0);
