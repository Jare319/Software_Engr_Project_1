extends Node

@export var asteroid_scene: PackedScene;
@export var projectile_scene: PackedScene
var score;
var stage;
var difficulty = 1.0;
var screen_size;
var screen_margin = 80;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().get_visible_rect().size;
	spawn_asteroids(clamp(6,4,INF));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in self.get_children():
		edge_detect(i);
	
func spawn_asteroids(count):
	for i in count:
		var asteroid = asteroid_scene.instantiate();
		asteroid.difficulty = self.difficulty;
		add_child(asteroid);

func edge_detect(i):
	if i.position.x > screen_size.x + screen_margin:
		i.position.x = 0 - screen_margin;
	if i.position.y > screen_size.y + screen_margin:
		i.position.y = 0 - screen_margin;
	if i.position.x < 0 - screen_margin:
		i.position.x = screen_size.x + screen_margin;
	if i.position.y < 0 - screen_margin:
		i.position.y = screen_size.y + screen_margin;

func _on_player_shoot():
	var projectile = projectile_scene.instantiate();
	projectile.heading = $Player.heading;
	projectile.position = $Player.position;
	add_child(projectile);
