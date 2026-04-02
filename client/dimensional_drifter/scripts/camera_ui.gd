extends Control

@onready var texture_rect = $TextureRect
@onready var animation_player = $AnimationPlayer
@onready var status_label = $StatusLabel

var camera_feed: CameraFeed
var camera_active = false

func _ready():
	hide()
	status_label.text = ""

func _input(event):
	if event.is_action_pressed("toggle_camera"):
		toggle_camera()
	
	if camera_active and event.is_action_pressed("take_picture"):
		take_picture()

func toggle_camera():
	camera_active = !camera_active
	visible = camera_active
	
	if camera_active:
		# Start webcam
		var feeds = CameraServer.feeds()
		if feeds.size() > 0:
			camera_feed = feeds[0]
			camera_feed.feed_is_active = true
			# We'll need a custom shader or material to display the CameraTexture
			var mat = StandardMaterial3D.new()
			# Note: In Godot 4, displaying camera feed in UI usually involves a CameraTexture
			var cam_tex = CameraTexture.new()
			cam_tex.camera_feed_id = camera_feed.get_id()
			texture_rect.texture = cam_tex
			status_label.text = "[C] Close | [LMB] Capture"
		else:
			status_label.text = "No webcam detected"
	else:
		if camera_feed:
			camera_feed.feed_is_active = false
		status_label.text = ""

func take_picture():
	if not camera_feed or not camera_feed.feed_is_active:
		return
		
	status_label.text = "Processing..."
	# In Godot 4, capturing the exact frame from a CameraTexture needs a viewport or getting the image
	# For now, we will grab the viewport texture as a placeholder
	await get_tree().process_frame
	var img = get_viewport().get_texture().get_image()
	
	# Play shutter animation
	animation_player.play("shutter")
	
	# Convert to base64
	var buffer = img.save_jpg_to_buffer()
	var base64_str = Marshalls.raw_to_base64(buffer)
	
	# Send to backend
	send_to_backend(base64_str)

func send_to_backend(base64_img: String):
	# We will implement the HTTPRequest logic here
	print("Sending image to backend, length: ", base64_img.length())
	# Simulate API call delay
	await get_tree().create_timer(1.0).timeout
	status_label.text = "Analysis Complete"
	# Close camera after success
	await get_tree().create_timer(1.0).timeout
	toggle_camera()
