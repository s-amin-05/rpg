extends CharacterBody2D

const SPEED = 50.0
var is_chasing = false
var player = null

func _physics_process(delta: float) -> void:
	if player and is_chasing:
		velocity = (player.position - position).normalized() * SPEED * delta * Globals.FRAMERATE	 
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	is_chasing = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	is_chasing = false
