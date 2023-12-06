extends CharacterBody2D


const SPEED = 100
var initial_position = Vector2.ZERO
var direction = Vector2.LEFT
var detection_range
var player
var chase = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	initial_position = position
	detection_range = get_node("PlayerDetection")
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	position += direction * SPEED * delta
	
	if position.x < initial_position.x - 100:
		direction = Vector2.RIGHT
	elif position.x > initial_position.x + 100:
		direction = Vector2.LEFT
		
	player = get_node("../../Player")
	

	move_and_slide()


func death():
	Game.Gold += 15
	Utils.saveGame()
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished 
	self.queue_free()



func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		death()


func _on_player_death_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 20
