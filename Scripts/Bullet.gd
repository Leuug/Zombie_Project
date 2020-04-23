extends Area2D

var velocity = 600
var move = Vector2()


func start(pos, dir):
	rotation = dir
	position = pos
	move = Vector2(1 , 0).rotated(rotation)


func _process(delta):
	position += move * velocity * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.has_method("die"):
		body.die()
		Game.score += 1
	
	queue_free()
