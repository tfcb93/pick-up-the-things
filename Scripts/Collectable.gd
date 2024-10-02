extends Area3D

@onready var NormalMesh := $NormalMesh;
@onready var SpecialMesh := $SpecialMesh;

@export var addTime := 0;

const SPEED := 20.0;

var followPlayer := false;
var player = Node;

func _physics_process(delta: float) -> void:
	if followPlayer:
		position = position.lerp(player.position, delta * SPEED);

func _on_body_entered(body):
	if (body.name == 'Player'):
		events.emit_signal("collectable_picked");
		if addTime != 0:
			events.emit_signal("_add_time",addTime);
		globals.totalCollected += 1;
		queue_free();


func _on_area_entered(area: Area3D) -> void:
	if(area.name == "PlayerMagnetField"):
		followPlayer = true;
		player = area.get_parent();

func change_add_time(value) -> void:
	addTime = value;
	NormalMesh.visible = false;
	SpecialMesh.visible = true;
