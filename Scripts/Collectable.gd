extends Area3D

const SPEED := 20.0;

var followPlayer := false;
var player = Node;

func _physics_process(delta: float) -> void:
	if followPlayer:
		position = position.lerp(player.position, delta * SPEED);

func _on_body_entered(body):
	if (body.name == 'Player'):
		Events.emit_signal("_collectable_picked");
		WorldGlobals.totalCollected += 1;
		queue_free();


func _on_area_entered(area: Area3D) -> void:
	if(area.name == "PlayerMagnetField"):
		followPlayer = true;
		player = area.get_parent();
