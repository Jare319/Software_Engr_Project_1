extends Area2D

var heading;
@export var speed = 40;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Lifetime.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += heading * speed;

func _on_lifetime_timeout():
	queue_free();
