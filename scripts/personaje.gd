extends CharacterBody2D

@export var velocidad := 400.0
@export var fuerza_salto := 750.0
@export var gravedad := 2800.0
@export var multiplicador_caida := 1.2

@onready var sprite: Sprite2D = $CollisionShape2D/Sprite2D
var intentos=0
func _physics_process(delta):
	# Avanza siempre
	velocity.x = velocidad

	# Gravedad (más fuerte al caer)
	if not is_on_floor():
		var g := gravedad
		if velocity.y > 0:
			g *= multiplicador_caida
		velocity.y += g * delta

	# Salto (mantener presionado = salta de nuevo al aterrizar)
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = -fuerza_salto

	move_and_slide()
	_rotar(delta)
	# Muere si choca de frente
	if is_on_wall():
		intentos+=1
		print(intentos)
		get_tree().reload_current_scene.call_deferred()
	

func _rotar(delta):
	if not is_on_floor():
		# 180° por salto aprox.
		var duracion := 2.0 * fuerza_salto / gravedad
		sprite.rotation_degrees += (180.0 / duracion) * delta
	else:
		# Al aterrizar se alinea al múltiplo de 90° más cercano
		var objetivo := snappedf(sprite.rotation_degrees, 90.0)
		sprite.rotation_degrees = move_toward(sprite.rotation_degrees, objetivo, 900.0 * delta)
