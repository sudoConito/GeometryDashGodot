extends Area2D
@onready var jugador:CharacterBody2D=$"../../personaje"
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		jugador.impulso(1300)
