extends Sprite2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		var pos = position + offset - ( (texture.get_size() / 2.0) if centered else Vector2() ) # added this 2
		if Rect2(pos, texture.get_size()).has_point(event.position): # added this
			print('test')
			#get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
