extends Area3D



func _on_body_entered(body):
	if (body.name == 'Player'):
		Events.emit_signal("_collectable_picked");
		queue_free();
