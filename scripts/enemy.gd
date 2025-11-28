extends CharacterBody2D

const SPEED = 50.0
var is_chasing = false
var player = null

func _physics_process(delta):
	if is_chasing and player:
		var dir = (player.position - position).normalized()
		var motion = dir * SPEED * delta
		
		var collision = move_and_collide(motion)
		if collision:
			# Stop when hitting the player instead of sliding/sticking
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	is_chasing = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	is_chasing = false
