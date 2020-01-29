extends Camera

var last_mouse_coordinate = Vector2(0,0)
var moving = false
var rotate_vector = Vector3()
var offset = Vector3()
var looking_up = false
var looking_down = false
var looking = false
var look_coordinates = Vector2(0,0)

func _ready():
    set_physics_process(true)
    set_process_input(true)
    set_as_toplevel(true)
    offset.y = 4

func _input(event):

    if event is InputEventMouse:
        if Input.is_action_just_pressed("view"):
            #print("Mouse Motion at: ", event.position)
#            if last_mouse_coordinate[0] > event.position[0]:
#                print("cclockwise")
#                rotate_vector = Vector3(1,0,1)
#            else:
#                print("clockwise")
#                rotate_vector = Vector3(-1,0,-1)
#            if last_mouse_coordinate[1] > event.position[1]:
#                #rotate_vector[1] = -1
#                looking_up = true
#                looking_down = false
#            else:
#                looking_up = false
#                looking_down = true
#                #rotate_vector[1] = 1
#
#            translate(rotate_vector)
            looking = true
            print(event.position)
            #print(get_transform())
            last_mouse_coordinate = event.position
    if Input.is_action_just_released("view"):
        print("released")
        looking = false
    if event is InputEventMouseMotion:

        if looking:
#            look_coordinates = event.position - last_mouse_coordinate
#            look_coordinates = look_coordinates.normalized()
            look_coordinates = event.relative
            print(look_coordinates)
            if look_coordinates.x < -.5:
                look_coordinates.x = .7
            elif look_coordinates.x > .5:
                look_coordinates.x = -.7
            else:
                look_coordinates.x = 0
            if look_coordinates.y < -.5:
                look_coordinates.y = -.7
            elif look_coordinates.y > .5:
                look_coordinates.y = .7
            else:
                look_coordinates.y = 0
#            print(look_coordinates)
            

func _physics_process(delta):
    if Input.is_action_pressed("view"):
        if look_coordinates.x < 0:
            translate(Vector3(look_coordinates.x,0,look_coordinates.x))
        else:
            translate(Vector3(look_coordinates.x,0,look_coordinates.x))
    if Input.is_action_pressed("forward") or Input.is_action_pressed("backward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
        moving = true
    else:
        moving = false
    var target = get_parent().get_global_transform().origin
    var pos = get_global_transform().origin
    var up = Vector3(0, 1, 0)

    offset = pos -target

    offset = offset.normalized()*10
    #print(offset)
    #print(OS.get_window_size())
    if not moving:
        if looking:
#            offset.x = offset.x + (look_coordinates.x * delta * 20)
#            offset.z = offset.z + (look_coordinates.x * delta * 20)
            translate(Vector3(1,0,1))
            offset.y = offset.y + (look_coordinates.y * delta * 20)
#            offset.y = offset.y + (look_coordinates.y * delta * 20)
    else:
        offset.y = 4

    pos = target + offset

    look_at_from_position(pos, target, up)