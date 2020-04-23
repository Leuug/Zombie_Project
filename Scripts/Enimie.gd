extends RigidBody2D

var velocity = 0.5
var move = Vector2()
var animation = "walk"
var atack = false
var player


func start(pos):
	global_position = pos


func _physics_process(delta):
	var target = Game.enimietarget
	
	$AnimationPlayer.play(animation)
	global_position = global_position.linear_interpolate(target, velocity * delta)
	
	if global_position.x > target.x:
		$Enimie_Sprite.flip_h = true
	else:
		$Enimie_Sprite.flip_h = false
	
	if atack == true:
		player.hit()
		$Timer.start()
		atack = false


func _on_Area2D_body_entered(body):
	if body.has_method("hit"):
		velocity = 0
		player = body
		animation = "atack"
		atack = true


func _on_Area2D_body_exited(_body):
	animation = "walk"
	velocity = 0.5
	atack = false
	$Timer.stop()


func die():
	atack = false
	animation = "die"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_Timer_timeout():
	atack = true
