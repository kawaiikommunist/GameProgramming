extends Node

var cdata = {}
var vdata = {}
var hls = {} 
var tile = load("res://tile.gd")
@onready
var disp = $display
var cpos = tile.new(0, 0, 0)
signal update
signal fire
var s = 8
@onready
var fireball = load("res://fireball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-s, s+1):
		for j in range(-s, s+1):
			for k in range(-s, s+1):
				if i+j+k!=0: continue
				var ntile = tile.new(i, j, k)
				if dist(ntile.tv(), Vector3i(0, 0, 0)) == 1:
					hls[ntile.tc()] = 1
				cdata[ntile.tc()] = ntile
				vdata[ntile.tv()] = ntile
	update.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func dist(a, b):
	return (abs(a.x-b.x) + abs(a.y-b.y) + abs(a.z-b.z))/2


func _on_display_select(cds, type):
	if type == 0:
		hls.clear()
		for i in cdata[cds].nc():
			hls[i] = 1
		update.emit()
	elif type == 1:
		var atk = fireball.instantiate()
		add_child(atk)
		atk.position = disp.map_to_local(cds)
		for i in cdata[cds].nc():
			atk = fireball.instantiate()
			add_child(atk)
			atk.position = disp.map_to_local(i)
		fire.emit()
