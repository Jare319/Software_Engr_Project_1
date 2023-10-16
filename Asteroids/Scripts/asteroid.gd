extends Area2D

@export var max_speed = 1000;
@export var min_speed = 40;
@export var size = 3; # Size of asteroids are indexed by 3 - largest, 2 - medium, 1 - small
@export var velocity = Vector2.ZERO;
var screen_size;
var difficulty; # float 0.5 - 2
# Called when the node enters the scene tree for the first time.
func _ready():
	max_speed = 75 * (4-size) * (difficulty);
	min_speed = 10 * (4-size) * (difficulty);
	velocity = Vector2((randf()*2)-1,(randf()*2)-1).normalized()*((max_speed-min_speed)+min_speed);
	$Polygon2D.color = Color.from_hsv(randf(),0.3,0.95);
	scale = Vector2(pow(1.5,size)-0.75,pow(1.5,size)-0.75);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
