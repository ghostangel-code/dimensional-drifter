extends Node3D
class_name StandeeGenerator

func generate_standee(image_base64: String, properties: Dictionary, spawn_position: Vector3):
	var img = Image.new()
	var raw_data = Marshalls.base64_to_raw(image_base64)
	var err = img.load_png_from_buffer(raw_data)
	if err != OK:
		print("Error loading image from base64")
		return
	
	var texture = ImageTexture.create_from_image(img)
	
	# Create RigidBody3D
	var rigid_body = RigidBody3D.new()
	rigid_body.position = spawn_position
	
	# Set mass
	if properties.has("mass"):
		rigid_body.mass = float(properties["mass"]) / 1000.0 # Assuming grams to kg
		
	# Create Sprite3D with billboard
	var sprite = Sprite3D.new()
	sprite.texture = texture
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite.transparent = true
	sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
	
	# Optional: apply Sobel outline shader material here later
	
	# Generate collision polygon based on alpha
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	var polys = bitmap.opaque_to_polygons(Rect2(0, 0, img.get_width(), img.get_height()), 2.0)
	
	if polys.size() > 0:
		var main_poly = polys[0]
		
		# Create a 3D polygon by extruding the 2D polygon
		var collision_shape = CollisionShape3D.new()
		var shape = ConvexPolygonShape3D.new()
		
		var points_3d = PackedVector3Array()
		# Scale down image coordinates to world space (e.g. 100 pixels = 1 meter)
		var pixel_to_meter = 0.01
		
		# Simplistic extrusion for Billboard: just a flat shape
		for pt in main_poly:
			var x = (pt.x - img.get_width() / 2.0) * pixel_to_meter
			var y = -(pt.y - img.get_height() / 2.0) * pixel_to_meter
			points_3d.append(Vector3(x, y, 0))
			
		shape.points = points_3d
		collision_shape.shape = shape
		rigid_body.add_child(collision_shape)
	
	rigid_body.add_child(sprite)
	get_tree().current_scene.add_child(rigid_body)
	
	# Display narration if any
	if properties.has("narration"):
		display_narration(properties["narration"], properties.get("is_passed", false))

func display_narration(text: String, is_passed: bool):
	# We will connect this to the main UI controller
	print("Judge says: ", text)
