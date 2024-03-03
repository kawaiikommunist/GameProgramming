extends Label

var ammo = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = "Ammo: %s" % ammo # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_arena_fire():
	ammo-=1
	self.text = "Ammo: %s" % ammo # Replace with function body.
