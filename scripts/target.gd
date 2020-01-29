extends Spatial

var last_mouse_coordinate = Vector2(1,0)
var current_mouse_coordinate = Vector2(0,0)

var speed = 4
var rotate_left = false
var rotate_right = false
var rotate_value
const ray_length = 1000

func _ready():
    pass

func _input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == 1:
          var camera = $Camera
          var from = camera.project_ray_origin(event.position)
          var to = from + camera.project_ray_normal(event.position) * ray_length
    get_world().direct_space_state

#func _input(event):
#    if event is InputEventMouseMotion:
#        if Input.is_action_pressed("view"):
#            current_mouse_coordinate = event.position
#            print("Mouse Motion at: ", event.position)
#            if last_mouse_coordinate[0] > current_mouse_coordinate[0]:
#                rotate_left = true
#                rotate_right = false
#            else:
#                rotate_right = true
#                rotate_left = false
#            last_mouse_coordinate = current_mouse_coordinate

#func _process(delta):
#    rotate_left = Input.is_action_pressed("ui_left")
#    rotate_right = Input.is_action_pressed("ui_right")
#    if rotate_left:
#        print("hey")
#        rotate_value = speed*delta
#        rotate_y(rotate_value)
#    if rotate_right:
#        rotate_value = -speed*delta
#        rotate_y(rotate_value)