extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn");


func _on_controls_button_pressed():
	$TextureRect.show();


func _on_exit_button_pressed():
	get_tree().quit();


func _on_return_button_pressed():
	$TextureRect.hide();
