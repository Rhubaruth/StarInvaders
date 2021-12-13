extends Area2D

 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(diff : float, speed):
	var destination = position
	destination.x += diff
	$Tween.interpolate_property(self, "position", null, destination, speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()


func _body_enter(body):
	if body.get_parent().name != "Shots":
		return
	body.visible = false
	
	get_tree().queue_delete(self)
	get_tree().queue_delete(body)
	
	pass # Replace with function body.
