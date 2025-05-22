extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # optional, use a group to identify the player
		body.die()  # Calls the player’s death function
