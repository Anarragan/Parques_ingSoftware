extends Node

var nombre = get_name()  # Nombre del jugador
var fichas = [$FichaC41]  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador


# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre
