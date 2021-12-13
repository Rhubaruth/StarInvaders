extends KinematicBody2D

var acc := 17.0
var max_speed := 120
var move_vec := Vector2()

var friction := 0.8

var bullet = preload("res://Player/Bullet.tscn")
var ammo = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	var input_vec = Vector2()
	if Input.is_action_pressed("left"):
		input_vec.x = -1
	elif Input.is_action_pressed("right"):
		input_vec.x = 1
	else:
		move_vec *= friction
	move_vec += input_vec * acc * friction
	if move_vec.length() > max_speed:
		move_vec.x = sign(move_vec.x) * max_speed
	
	move_vec = move_and_slide(move_vec)


func shoot():
	var new_bullet = bullet.instance()
	new_bullet.global_position = global_position
	$Shots.add_child(new_bullet)
	
	pass


func _input(event):
	if !Input.is_action_just_pressed("shoot"):
		return
	
	if $Shots.get_child_count() < ammo:
		shoot()
	
