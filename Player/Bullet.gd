extends KinematicBody2D


var speed = 150
var acc = 1.025
var dir = Vector2.UP

var move_vec = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	move_vec = dir * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_vec = move_and_slide(move_vec) * acc
	
	pass


func _screen_exit():
	queue_free()
	pass # Replace with function body.
