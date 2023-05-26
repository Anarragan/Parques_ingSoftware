extends Node

var jugadores = []  # Lista de jugadores (5 en el juego clasico)
var jugadorActual = null  # Jugador actual en turno
var turno = 0  # Número de turno actual
var dadosLanzados = false  # Indica si los dados han sido lanzados en el turno actual

# Agregar jugadores al GameMaster (Al inicio del juego)
func agregarJugador(jugador):
	jugadores.append(jugador)

# Cambiar al siguiente jugador en turno
func cambiarTurno():
	# Incrementar el número de turno
	turno += 1

	# Obtener el siguiente jugador en la lista de jugadores
	jugadorActual = jugadores[turno % len(jugadores)]

	# Reiniciar el estado de los dados lanzados
	dadosLanzados = false

# Lógica para validar y ejecutar el movimiento de una ficha por parte del jugador actual
func moverFicha(ficha):
	if jugadorActual != null and dadosLanzados:
		jugadorActual.moverFicha(ficha)
	else:
		print("Primero debes lanzar los dados.")
