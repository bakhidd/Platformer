extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var entry = false

var climbing =  false
#var direction = Input.get_axis("ui_up", "ui_down")

func _physics_process(delta):
	if climbing == false:
		velocity.y += gravity 
	elif climbing == true:
		velocity.y = 0
		if Input.is_action_pressed('ui_up'):
			velocity.y = -SPEED
		elif Input.is_action_pressed('ui_down'):
			velocity.y = SPEED

	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == 'Player':
		entry = true
		body.climbing = true


func _on_player_detection_body_exited(body):
	if body.name == 'Player':
		body.climbing = false
