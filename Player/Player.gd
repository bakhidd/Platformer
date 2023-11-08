extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer") #@onready is needed because otherwise we wouldn't be able to access anim in a function

#we need "_" before function's name for it to work

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor(): #if we are in the air we add velocity to the Y direction
		anim.play("Idle")
		velocity.y += gravity * delta
		

	# Handle Jump, we can only jump when we are on the floor
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		anim.play("Jump")
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right") #get_axis checks which one of 2 keys are being pressed,
	#ui_left => direction = -1, ui_right => 1, of neither => 0
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction: #if moving (ui_right or ui_left)
		velocity.x = direction * SPEED
		if velocity.y == 0: #if we are not in the air, we can run
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) #going from our velocity to 0at the SPEED amount of time
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")
			
	move_and_slide() #a build-in function wjich allows us to move and slide :D
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
