extends CharacterBody2D

const SPEED := 100.0

# Maps input actions to direction vectors
const INPUT_MAP := {
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

# Animation names for directions
const ANIM_MAP := {
	Vector2.LEFT:  {"walk": "side_walk",  "idle": "side_idle",  "flip": true},
	Vector2.RIGHT: {"walk": "side_walk",  "idle": "side_idle",  "flip": false},
	Vector2.UP:    {"walk": "back_walk",  "idle": "back_idle",  "flip": false},
	Vector2.DOWN:  {"walk": "front_walk", "idle": "front_idle", "flip": false}
}

var direction := Vector2.RIGHT
var is_moving := false

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	play_animation()
	move_and_slide()

func handle_movement(delta) -> void:
	var input_vector := Vector2.ZERO
	
	for action in INPUT_MAP.keys():
		if Input.is_action_pressed(action):
			input_vector = INPUT_MAP[action]
			break

	is_moving = input_vector != Vector2.ZERO

	if is_moving:
		direction = input_vector
		velocity = direction * SPEED * delta * Globals.FRAMERATE
	else:
		velocity = Vector2.ZERO

func play_animation() -> void:
	var player_sprite := $AnimatedSprite2D
	var anim = ANIM_MAP[direction]

	player_sprite.flip_h = anim["flip"]

	if is_moving:
		player_sprite.play(anim["walk"])
	else:
		player_sprite.play(anim["idle"])
