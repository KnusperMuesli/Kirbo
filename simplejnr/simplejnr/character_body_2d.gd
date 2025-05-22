extends CharacterBody2D

const SPEED = 300
const JUMP_FORCE = -400
const GRAVITY = 500
const DEATH_Y = 1000

var is_dead = false
var has_won = false
var spawn_position: Vector2

@onready var sprite = $Sprite2D
@onready var win_screen = get_node("/root/" + get_tree().current_scene.name + "/WinningScreen")
@onready var death_screen = get_node("/root/" + get_tree().current_scene.name + "/DeathScreen")

func _ready():
	spawn_position = global_position
	if win_screen:
		win_screen.visible = false
	if death_screen:
		death_screen.visible = false

func _physics_process(delta):
	if is_dead or has_won:
		if Input.is_action_just_pressed("jump"):
			get_tree().reload_current_scene()
		return

	var direction = 0.0

	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1

	velocity.x = direction * SPEED

	if direction != 0:
		sprite.flip_h = direction < 0

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE

	move_and_slide()

	print(global_position.y)
	if global_position.y > DEATH_Y:
		die()

func die():
	is_dead = true
	velocity = Vector2.ZERO
	if death_screen:
		death_screen.visible = true

func win():
	has_won = true
	velocity = Vector2.ZERO
	if win_screen:
		win_screen.visible = true
