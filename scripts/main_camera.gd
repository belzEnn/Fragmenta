extends Camera2D

@export var move_speed := 1500.0   # Скорость перемещения
@export var zoom_speed := 0.1     # Скорость зума
@export var min_zoom := 0.5       # Минимальный зум
@export var max_zoom := 1.0       # Максимальный зум

func _process(delta):
	var move = Vector2.ZERO
	
	# Движение камеры
	if Input.is_action_pressed("W"):
		move.y -= 1
	if Input.is_action_pressed("S"):
		move.y += 1
	if Input.is_action_pressed("A"):
		move.x -= 1
	if Input.is_action_pressed("D"):
		move.x += 1

	position += move.normalized() * move_speed * delta

func _input(event):
	# Зум колёсиком мыши
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += Vector2(zoom_speed, zoom_speed)

		# Ограничение зума
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
