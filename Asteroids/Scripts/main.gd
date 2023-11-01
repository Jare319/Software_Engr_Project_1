extends Node

@export var asteroid_scene: PackedScene;
@export var projectile_scene: PackedScene
var score = 0;
var stage = 1;
var difficulty = 1.0;
var screen_size;
var screen_margin = 80;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().get_visible_rect().size;
	$PlayerSpawn.position = screen_size/2;
	new_game();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in self.get_children():
		if (i.is_in_group("MoveObjects")):
			edge_detect(i);
	print(get_child_count())
	if self.get_child_count() == 6 && $NewLevelTimer.is_stopped():
		difficulty += 0.1;
		stage+= 1;
		$NewLevelTimer.start();
		
	
func spawn_asteroids(count,pos,size):
	for i in count:
		var asteroid = asteroid_scene.instantiate();
		asteroid.difficulty = self.difficulty;
		asteroid.difficulty += (stage-1)*0.5;
		asteroid.position = pos;
		asteroid.size = size;
		call_deferred("add_child",asteroid);

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
	
func game_over():
	$GameOverText.show();
	$GameOverTimer.start();

func new_level():
	$Player.position = $PlayerSpawn.position;
	$Player.heading = Vector2.UP;
	spawn_asteroids(round(pow(1.3,stage-1)+5),Vector2(-60,-60),3);

func new_game():
	self.difficulty = 1;
	self.score = 0;
	$ScoreText.update_score_label(score);
	self.stage = 1;
	new_level();

func increment_score():
	self.score += 10;
	$ScoreText.update_score_label(score);

func _on_new_level_timer_timeout():
	new_level();

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/startmenu.tscn");
