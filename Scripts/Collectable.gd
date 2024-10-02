extends Area3D;

const SPEED := 20.0;

@onready var NormalMesh := $NormalMesh;
@onready var SpecialMesh := $SpecialMesh;

@export var add_time := 0;

var follow_player := false;
var player = Node; # I could not infer type due to: 'Value of type "Node" cannot be assigned to a variable of type "GDScriptNativeClass"'

func _physics_process(delta: float) -> void:
	if follow_player:
		position = position.lerp(player.position, delta * SPEED);

func _on_body_entered(body) -> void:
	if (body.name == 'Player'):
		events.emit_signal("collectable_picked");
		if (add_time != 0):
			events.emit_signal("add_time", add_time);
		globals.total_collected += 1;
		queue_free();

func _on_area_entered(area: Area3D) -> void:
	if(area.name == "PlayerMagnetField"):
		follow_player = true;
		player = area.get_parent();

func change_add_time(value: int) -> void:
	add_time = value;
	NormalMesh.visible = false;
	SpecialMesh.visible = true;
