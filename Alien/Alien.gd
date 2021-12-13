extends Area2D

var unleashed := false 
var speed := 155

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(diff : float, speed):
	var destination = position
	destination.x += diff
	$Tween.interpolate_property(self, "position", null, destination, speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()


func unleash():
	var old_pos = global_position
	var Game = get_node("/root/Game")
	get_parent().remove_child(self)
	Game.add_child(self)
	self.global_position = old_pos
	$Tween.stop_all()
	unleashed = true
	
	var destination = global_position
	destination.y = 300
	var time = (destination.y - global_position.y) / speed
	$Anim.play("Pre_Attack")
	$Tween.interpolate_property(self, "global_position", null, destination, time, Tween.TRANS_CUBIC, Tween.EASE_IN, 0.6)
	$Tween.start()


func _body_enter(body):
	if body.name == "Player":
#		print(name)
		body.hit()
		$Tween.stop(self, "global_position")
		$Collision.set_deferred("disabled", true)
		
		$Tween.interpolate_property($Sprite, "self_modulate", null, Color(1,1,1,0), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
		$Tween.start()
		return

	elif body.get_parent().name != "Shots":
		return
	body.visible = false
	$Tween.stop(self, "global_position")
	$Collision.set_deferred("disabled", true)
	$Tween.connect("tween_completed", self, "delete_self")
	
	$Tween.interpolate_property($Sprite, "self_modulate", null, Color(1,1,1,0), 0.45, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	get_tree().queue_delete(body)


func delete_self(obj, key):
	if key != "self_modulate" and obj != $Sprite:
		return
	get_tree().queue_delete(self)
