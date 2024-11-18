extends Button

@export var normal_texture : Texture
@export var pressed_texture : Texture
@export var hover_texture : Texture

func _ready():
	var normal_stylebox = StyleBoxTexture.new()
	var pressed_stylebox = StyleBoxTexture.new()
	var hover_stylebox = StyleBoxTexture.new()
	
	if normal_texture and pressed_texture and hover_texture:
		normal_stylebox.texture = normal_texture
		pressed_stylebox.texture = pressed_texture
		hover_stylebox.texture = hover_texture
		
		add_theme_stylebox_override("normal", normal_stylebox)
		add_theme_stylebox_override("pressed", normal_stylebox)
		add_theme_stylebox_override("hover", normal_stylebox)
