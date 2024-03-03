class_name tile

var x: int
var y: int
var z: int
var i = 0
var e = []
var t = Vector2i(0,0)

func _init(a, b = null, c = null):
	if a is Vector2i:
		self.x = -(a.y-a.x)
		self.y = -a.x
		self.z = a.y
	elif a is Vector3i:
		self.x = a.x
		self.y = a.y
		self.z = a.z
	else:
		self.x = a
		self.y = b
		self.z = c

func tc():
	return Vector2i(-self.y, self.z)
	
func tcbutdiffbecausegdscriptdumb(v: Vector3i):
	return Vector2i(-v.y, v.z)
	
func tv():
	return Vector3i(self.x, self.y, self.z)
	
func ns():
	var ret = []
	for i in [-1, 1]:
		ret.push_front(Vector3i(self.x+i, self.y, self.z))
		ret.push_front(Vector3i(self.x, self.y+i, self.z))
		ret.push_front(Vector3i(self.x, self.y, self.z+i))
	return ret
	
func nc():
	var ret = []
	for i in [-1, 1]:
		ret.push_front(tcbutdiffbecausegdscriptdumb(Vector3i(self.x+i, self.y, self.z+i)))
		ret.push_front(tcbutdiffbecausegdscriptdumb(Vector3i(self.x+i, self.y+i, self.z)))
		ret.push_front(tcbutdiffbecausegdscriptdumb(Vector3i(self.x, self.y-i, self.z+i)))
	return ret
