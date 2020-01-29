extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
var character


const SPEED = 16
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	#fps camera right now is disabled 
	camera = get_node("./target/Camera").get_global_transform()
	character = get_node(".")
	
func _physics_process(delta):
	if is_network_master():
	    camera = get_node("./target/Camera").get_global_transform()
	    
	    var dir = Vector3()
	    var is_moving = false
	    if (Input.is_action_pressed("forward")):
	        #print(-camera.basis[2])
	        dir += -camera.basis[2]
	        is_moving = true
	    if (Input.is_action_pressed("backward")):
	        dir += camera.basis[2]
	        is_moving = true
	    if (Input.is_action_pressed("left")):
	        dir += -camera.basis[0]
	        is_moving = true
	    if (Input.is_action_pressed("right")):
	        dir += camera.basis[0]
	        is_moving = true
	    if (Input.is_action_just_pressed("jump")):
	        print("jump")
	        is_moving = true
	        velocity.y = 5
	    	
	    
	    #dir.y == 0
	    dir = dir.normalized()
	    
	    velocity.y += delta * gravity
	    
	    var hv = velocity
	    hv.y = 0
	    
	    var new_pos = dir * SPEED
	    var accel = DE_ACCELERATION
	    
	    if (dir.dot(hv) > 0):
	    	accel = ACCELERATION
	    	
	    hv = hv.linear_interpolate(new_pos, accel * delta)
	    
	    velocity.x = hv.x
	    velocity.z = hv.z
	    
	    
	    #else:
	    #    velocity.x = lerp(velocity.x, 0.0, 0.1)
	    #    #print("ayy")
	    #print(velocity.x)
	    
	    if is_moving:
	    	var angle = atan2(hv.x, hv.z)
	    	var char_rot = character.get_rotation()
	    	char_rot.y = angle
	    	character.set_rotation(char_rot)
	    
	    velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	    rpc_unreliable("update_trans_rot", translation, rotation, character.rotation)
    

# Sync position and rotation in the network
puppet func update_trans_rot(pos, rot, shape_rot):
    translation = pos
    rotation = rot
    character.rotation = shape_rot