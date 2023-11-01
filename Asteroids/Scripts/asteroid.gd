extends Area2D

@export var max_speed = 1000;
@export var min_speed = 40;
@export var size = 3; # Size of asteroids are indexed by 3 - largest, 2 - medium, 1 - small
@export var velocity = Vector2.ZERO;
signal hitSignal;
var screen_size;
var difficulty; # float; 1 at stage 1, scales linearly with each additional level
# Called when the node enters the scene tree for the first time.
func _ready():
	max_speed = 75 * pow(1.3,(4-size)) * (difficulty);
	min_speed = 10 * (4-size) * (difficulty);
	velocity = Vector2((randf()*2)-1,(randf()*2)-1).normalized()*((max_speed-min_speed)+min_speed);
	$Polygon2D.color = Color.from_hsv(randf(),0.3,0.95);
	$Polygon2D.scale = Vector2(pow(1.25,size)-0.8,pow(1.25,size)-0.8);
	$CollisionShape2D.scale = Vector2(pow(1.25,size)-0.8,pow(1.25,size)-0.8);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	
func split():
	if (self.size > 1):
		self.get_parent().spawn_asteroids(2,self.position,self.size-1);
	queue_free();

func _on_area_entered(area):
	self.get_parent().call_deferred("increment_score");
	split();
