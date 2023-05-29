extends Node

var jugadores = ["Jugador1", "Jugador2", "Jugador3", "Jugador4"] # Lista de jugadores (5 en el juego clásico)
var jugadorActual = jugadores[0]  # Jugador actual en turno
var turno = 0  # Número de turno actual
var dadosLanzados = false  # Indica si los dados han sido lanzados en el turno actual
var labelTurno = null
var anuncioLabel = null

func _ready():
	labelTurno = get_node("../VBoxContainer/Jugador")
	anuncioLabel = get_node("../VBoxContainer/Anuncios")
	actualizarTurno()
	
func obtenerJugador():
	return jugadorActual
	
func cambiar_anuncio(anuncio):
	anuncioLabel.text = anuncio

func actualizarTurno():
	labelTurno.text = jugadorActual
	

	# Cambia el estilo del texto según el jugador actual
	if jugadorActual == jugadores[0]:
		labelTurno.add_color_override("font_color", Color(1, 1, 0)) # Amarillo
	elif jugadorActual == jugadores[1]:
		labelTurno.add_color_override("font_color", Color(1, 0, 0)) # Rojo
	elif jugadorActual == jugadores[2]:
		labelTurno.add_color_override("font_color", Color(0, 1, 0)) # Verde
	else:
		labelTurno.add_color_override("font_color", Color(0, 0, 1)) # Azul

# Agregar jugadores al GameMaster (Al inicio del juego)
func agregarJugador(jugador):
	jugadores.append(jugador)

# Cambiar al siguiente jugador en turno
func cambiarTurno():
	# Incrementar el número de turno
	turno += 1
	print(turno)

	# Obtener el siguiente jugador en la lista de jugadores
	jugadorActual = jugadores[turno % len(jugadores)]
	print(jugadorActual)
	actualizarTurno()

	# Reiniciar el estado de los dados lanzados
	#dadosLanzados = false

