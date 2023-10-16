extends Area2D

@export var max_speed = 400;
@export var accel_coeff = 10;
@export var rotate_speed = 0.1; # How many radians the player will rotate per frame when turning
@export var velocity_damp = 0.25; # Velocity damping coefficient (between 0-1)
var heading = Vector2.UP;
var velocity = Vector2.ZERO;
var acceleration = Vector2.ZERO;
var screen_size;
signal shoot;
var on_cooldown = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acceleration = Vector2.ZERO;
	
	if Input.is_action_pressed("boost"):
		acceleration += heading;
	if Input.is_action_pressed("rotate_left"):
		heading.x = heading.x * cos(-rotate_speed) - heading.y * sin(-rotate_speed);
		heading.y = heading.x * sin(-rotate_speed) + heading.y * cos(-rotate_speed);
	if Input.is_action_pressed("rotate_right"):
		heading.x = (heading.x * cos(rotate_speed) - heading.y * sin(rotate_speed));
		heading.y = (heading.x * sin(rotate_speed) + heading.y * cos(rotate_speed));
	if Input.is_action_pressed("shoot") and !on_cooldown:
		shoot.emit();
		$Shoot_cooldown.start();
		on_cooldown = true;
		
	acceleration = acceleration.normalized() * accel_coeff;
	velocity += acceleration*delta;
	heading = heading.normalized();
	# velocity.clamp(Vector2.ZERO,Vector2(max_speed,max_speed));
	
	position += velocity * delta;
	velocity *= pow(velocity_damp, delta);
	rotation = heading.angle();
	
func _on_shoot_cooldown_timeout():
	on_cooldown = false;
