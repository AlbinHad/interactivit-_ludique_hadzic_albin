extends Control

@onready var background: Sprite2D = $background
@onready var player_z: AudioStreamPlayer2D = $AudioPlayerZ
@onready var player_x: AudioStreamPlayer2D = $AudioPlayerX

var image_jaune: Texture2D = preload("res://assets/images/image_jaune.jpg")
var image_verte: Texture2D = preload("res://assets/images/image_verte.jpg")

func _ready():
	background.texture = image_jaune  

func _process(_delta):
	if Input.is_action_just_pressed("go_mallet"):
		_play_sound(player_z, -3.0)
		_change_background(image_jaune)

	if Input.is_action_just_pressed("go_surge"):
		_play_sound(player_x, 5.0)
		_change_background(image_verte)

func _play_sound(player: AudioStreamPlayer2D, volume: float):
	player.volume_db = volume
	player.stop()
	player.play()

func _change_background(new_texture: Texture2D):
	var tween = create_tween()  # tween
	tween.tween_property(background, "modulate:a", 0.0, 0.3)  # fade out
	tween.tween_callback(Callable(self, "_set_texture").bind(new_texture))
	tween.tween_property(background, "modulate:a", 1.0, 0.3)  # fade in

func _set_texture(new_texture: Texture2D):
	background.texture = new_texture
