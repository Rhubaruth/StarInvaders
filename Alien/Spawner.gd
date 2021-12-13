extends Node2D


var dir = -1
var diff = 16
var dur = 1
var boarder = 112


onready var tween = get_parent().get_node("Tween")
onready var timer = get_parent().get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_aliens():
	if get_child_count() < 1:
		return
	
	if dir == -1:
		if get_child(0).position.x + dir*diff < -boarder:
			move_down()
			dir = 1
			return
		
		for child in get_children():
			child.move(dir*diff, 1)    # Always Slide 1 Block
	
	if dir == 1:
		if get_child(get_child_count()-1).position.x + dir*diff > boarder:
			move_down()
			dir = -1
			return
		
		for child in get_children():
			child.move(dir*diff, 1)    # Always Slide 1 Block


func move_down():
	var destination = position
	destination.y += diff
	tween.interpolate_property(self, "position", null, destination, 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	pass

func _on_Timer_timeout():
	move_aliens()
	pass # Replace with function body.
