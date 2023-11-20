extends CollisionShape2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var entry = 0
#var direction = Input.get_axis("ui_up", "ui_down")

func _physics_process(delta):
	if entry == 1:
		if Input.is_action_pressed('ui_up'):
			velocity.y += gravity * delta #Gravity
		else:
			velocity.y = 0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		entry = 1
