extends KinematicBody2D

var velocity = 160
var move = Vector2()
var animation = "right"
var bullet = preload("res://Assets/Spaw_Objects/Bullet.tscn")
var can_shoot = true
var life = 5
var _change_scene
onready var _delay_timer = Timer.new()


func _ready():
	life = 5
	Game.enimietarget = self.global_position
	
	add_child(_delay_timer)
	_delay_timer.connect("timeout", self, "_on_DelayTimer_timeout")


func _process(_delta):
	Game.enimietarget = self.global_position
	
	if get_global_mouse_position() < self.global_position:
		animation = "left"
	else:
		animation = "right"


func _physics_process(_delta):
	$CanvasLayer/life.text = "Life: " + str(life)
	$CanvasLayer/score.text = "Score: " + str(Game.score)
	move = move_and_slide(move, Vector2(), false, 4, PI/4, false)
	
	if Input:
		_check_input()
	
	if move == Vector2():
		$Cop_animations.play("idle_"+animation)
	
	if Input.is_mouse_button_pressed(1):
		shoot()
		
	if life < 0:
		_change_scene = get_tree().change_scene("res://Scenes/Menus/Game Over.tscn")


func shoot():
	if can_shoot == true:
		can_shoot = false
		_delay_timer.start(1)
		
		var b = bullet.instance()
		b.start($Gun/Gun_Barrel.global_position, $Gun.rotation)
		get_parent().add_child(b)


func _check_input():
	if Input.is_action_pressed("ui_right"):
		move.x = velocity
		$Cop_animations.play(animation)
	elif Input.is_action_pressed("ui_left"):
		move.x = -velocity
		$Cop_animations.play(animation)
	else:
		move.x = 0

	if Input.is_action_pressed("ui_up"):
		move.y = -velocity
		$Cop_animations.play(animation)
	elif Input.is_action_pressed("ui_down"):
		move.y = velocity
		$Cop_animations.play(animation)
	else:
		move.y = 0


func _on_DelayTimer_timeout():
	can_shoot = true


func hit():
	$Cop_animations2.play("hit")
	life -= 1
	print(life)
