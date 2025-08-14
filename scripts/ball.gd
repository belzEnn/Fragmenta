extends RigidBody2D

var is_dragged := false
var drag_strength := 1000.0
var damping := 0.9  # коэффициент затухания скорости

func _ready():
	input_pickable = true  # разрешаем кликать по телу

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragged = true

func _unhandled_input(event):
	# Сброс перетаскивания при отпускании ЛКМ в любом месте
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		is_dragged = false

func _physics_process(delta):
	if is_dragged:
		var target = get_global_mouse_position()
		var dir = target - global_position
		# затухание скорости, чтобы движение было мягче
		linear_velocity *= damping
		# притягиваем к мыши
		apply_central_force(dir * drag_strength)
