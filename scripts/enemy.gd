extends CharacterBody2D

const SPEED = 50.0
var is_chasing = false
var direction = Vector2.RIGHT
var player = null

func _physics_process(delta):
	handle_movement(delta)
	play_animation()
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	is_chasing = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	is_chasing = false

func handle_movement(delta):
	if is_chasing and player:
		direction = (player.position - position).normalized()
		var motion = direction * SPEED * delta
		
		var collision = move_and_collide(motion)
		if collision:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

const ANIM_MAP := {
	Vector2.LEFT:  {"jump": "side_jump",  "idle": "side_idle",  "flip": true},
	Vector2.RIGHT: {"jump": "side_jump",  "idle": "side_idle",  "flip": false},
	Vector2.UP:    {"jump": "back_jump",  "idle": "back_idle",  "flip": false},
	Vector2.DOWN:  {"jump": "front_jump", "idle": "front_idle", "flip": false}
}

func play_animation():
	var enemy_sprite = $AnimatedSprite2D
	var anim = ANIM_MAP[snap_to_cardinal(direction)]
	
	enemy_sprite.flip_h = anim['flip']
	if is_chasing:
		enemy_sprite.play(anim['jump'])
	else:
		enemy_sprite.play(anim['idle'])

func snap_to_cardinal(vec: Vector2) -> Vector2:
	if abs(vec.x) > abs(vec.y):
		return Vector2(sign(vec.x), 0)   
	else:
		return Vector2(0, sign(vec.y)) 
