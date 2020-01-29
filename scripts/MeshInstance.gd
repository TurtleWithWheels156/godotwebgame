extends MeshInstance

#var last_mouse_coordinate = Vector2(0,0)

var last_mouse_coordinate = Vector2(1,0)
var current_mouse_coordinate = Vector2(0,0)

var speed = 4
var rotate_left = false
var rotate_right = false
var rotate_value

func _ready():
	set_physics_process(true)
	set_process_input(true)
	set_as_toplevel(true)

#func _input(event):
#	if event is InputEventMouseMotion:
#		if Input.is_action_pressed("view"):
#	        print("Mouse Motion at: ", event.position)
#	        if last_mouse_coordinate[0] > event.position[0]:
#	            translate(Vector3(1,0,1))
#	        else:
#	            translate(Vector3(-1,0,-1))
#	        last_mouse_coordinate = event.position
#
#func _physics_process(delta):
#	var target = get_parent().get_global_transform().origin
#	var pos = get_global_transform().origin
#	var up = Vector3(0, 1, 0)
#
#	var offset = pos -target
#
#	offset = offset.normalized()*10
#	#print(offset)
#	#print(OS.get_window_size())
#	offset.y = 4
#
#	pos = target + offset
#
#	look_at_from_position(pos, target, up)

func _process(delta):
    rotate_left = Input.is_action_pressed("ui_left")
    rotate_right = Input.is_action_pressed("ui_right")
    if rotate_left:
        rotate_value = speed*delta
        rotate_y(rotate_value)
    if rotate_right:
        rotate_value = -speed*delta
        rotate_y(rotate_value)

