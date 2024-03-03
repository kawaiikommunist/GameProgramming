extends TileMap

var ti = load("res://tile.gd")
var lstpos

const ml = 0
const id = 0
var it = Vector3i(0, 0, 0)
@onready
var cam = $cam
@onready
var char = $char
@onready
var arena = get_parent()
signal select(coords, type)
@onready
var atk = $explosion


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var tile = arena.cdata.get(local_to_map(get_local_mouse_position()))
		if tile != null:
			if arena.hls.get(tile.tc()) and arena.hls.get(tile.tc()) == 1:
				cam.target = map_to_local(tile.tc())
				char.position = map_to_local(tile.tc())
				arena.cpos = tile
				select.emit(tile.tc(), 0)
				lstpos = null
			elif arena.dist(tile, arena.cpos) >= 2:
				select.emit(tile.tc(), 1)
	if event is InputEventMouseMotion:
		highlight()

func highlight():
	var tile = arena.cdata.get(local_to_map(get_local_mouse_position()))
	if tile and arena.hls.get(tile.tc()) == 1:
		set_cell(ml, tile.tc(), id, tile.t, 2)
	elif tile and arena.dist(tile, arena.cpos) >= 2:
		set_cell(ml, tile.tc(), id, tile.t, 3)
		for i in tile.nc():
			var t = arena.cdata.get(i)
			if t: set_cell(ml, i, id, t.t, 3)
	if lstpos and lstpos != tile: 
		var j = arena.hls.get(lstpos.tc())
		if !j: j = 0
		set_cell(ml, lstpos.tc(), id, lstpos.t, j)
		for i in lstpos.nc():
			j = arena.hls.get(i)
			if !j: j = 0
			var t = arena.cdata.get(i)
			if t: set_cell(ml, i, id, t.t, j)
	lstpos = tile


func _ready():
	var tile = arena.cpos
	cam.target = map_to_local(tile.tc())
	char.position = map_to_local(tile.tc())

func _process(delta):
	pass

func _on_arena_update():
	for i in arena.cdata:
		var t = arena.cdata[i]
		var j = arena.hls.get(i)
		if !j: j = 0
		set_cell(ml, i, id, t.t, j)
	highlight()
