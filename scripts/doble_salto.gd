extends Area2D
@onready var jugador:CharacterBody2D=$"../../personaje"
var estasDentro=false
func _process(delta: float) -> void:
	if estasDentro:
		if Input.is_action_just_pressed("ui_accept"):
			jugador.impulso(200)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		estasDentro=true
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		estasDentro=false
