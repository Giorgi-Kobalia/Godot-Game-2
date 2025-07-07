extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -300.0

const animated_sprite_offset_left =  -14
const animated_sprite_offset_right = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	animated_sprite.offset.x = animated_sprite_offset_right

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		animated_sprite.flip_h = true if direction < 0 else false
		animated_sprite.offset.x = animated_sprite_offset_left if direction < 0 else animated_sprite_offset_right
		animated_sprite.animation = "run"
		velocity.x = direction * SPEED
	else:
		animated_sprite.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
