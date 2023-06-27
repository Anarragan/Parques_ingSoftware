extends Node2D

# TO DO: Hacer la gestion de turnos de cada jugar (de hecho, según los diagramas que tenemos, deberia de existir
	#   un game master para esto, lo ideal crear un script aparte o global)
	
# TO DO: Debe existir el objeto jugador que basicamente se encargara de "recibir" el turno y asi sus fichas son las que se mueven,
# pasar turno, ser soplado, etc. 

# TO DO: Hacer la funcionalida de "soplar" (lo mismo, lo ideal seria introducirlo en el game master)

# TO DO: el jugador con el turno correspondiente debera seleccionar algunas de las fichas que tiene 
# disponibles en el campo de juego (digo "algunas" ya que el jugador tendra la posibilidad de mover
# una ficha de acuerdo al valor de un dado y otra ficha de acuerdo al valor del otro, o bien, mover 
# la ficha de acuerdo al valor de los dos dados)

# TO DO: se muestre los label correspondientes que indiquen informacion necesaria para los jugadores como
# turno del jugador correspondiente, tiempo, funcionalidad de lanzar los dados, botones
# o funcionalidad de hacer que la ficha seleccionada se mueva de acuerdo a tres casos:
		# 1. mover n casillas de acuerdo al valor del dado1
		# 2. mover n casillas de acuerdo al valor del dado2
		# 3. mover n casilla de acuerdo al valor de la suma de los dados

# Called when the node enters the scene tree for the first time.
var nodo_game_master = null
var frame_dado1
var frame_dado2
var jugador1
var jugador2
var jugador3
var jugador4
var dado1 = null
var dado2 = null
func _ready():
	nodo_game_master = $GameMaster
	jugador1 = $Jugador1
	jugador2 = $Jugador2
	jugador3 = $Jugador3
	jugador4 = $Jugador4
	dado1 = get_node("Dado1")
	dado2 = get_node("Dado2")
	# Obtener una referencia a los nodos AnimatedSprite de los dados




func _on_Button_pressed():
	lanzar_dados()

func lanzar_dados():
	# Restablecer los intentos y lanzamientos restantes al inicio del turno de un jugador

	# Seleccionar un frame aleatorio para cada dado
	var frame_dado1 = round(rand_range(0, 5))
	var frame_dado2 = round(rand_range(0, 5))
	# Establecer el frame seleccionado para cada dado
	dado1.frame = frame_dado1
	dado2.frame = frame_dado2

	var jugadorConTurno = get_node(nodo_game_master.obtenerJugador())

	if nodo_game_master.obtenerJugador() == "Jugador1" and !jugador1.getFichasAfuera():
		$FichaC11/ficha.sacar_ficha(frame_dado1, frame_dado2, $FichaC11)
	elif nodo_game_master.obtenerJugador() == "Jugador2" and !jugador2.getFichasAfuera():
		$FichaC21/ficha.sacar_ficha(frame_dado1, frame_dado2, $FichaC21)
	elif nodo_game_master.obtenerJugador() == "Jugador3" and !jugador3.getFichasAfuera():
		$FichaC31/ficha.sacar_ficha(frame_dado1, frame_dado2, $FichaC31)
	elif nodo_game_master.obtenerJugador() == "Jugador4" and !jugador4.getFichasAfuera():
		$FichaC41/ficha.sacar_ficha(frame_dado1, frame_dado2, $FichaC41)




func _on_BDado1_pressed():
	if nodo_game_master.obtenerJugador() == "Jugador1":
		$FichaC11/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC11, false)
	elif nodo_game_master.obtenerJugador() == "Jugador2":
		$FichaC21/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC21, false)
	elif nodo_game_master.obtenerJugador() == "Jugador3":
		$FichaC31/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC31, false)
	else:
		$FichaC41/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC41, false)


func _on_BDado2_pressed():
	if nodo_game_master.obtenerJugador() == "Jugador1":
		$FichaC11/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC11, true)
	elif nodo_game_master.obtenerJugador() == "Jugador2":
		$FichaC21/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC21, true)
	elif nodo_game_master.obtenerJugador() == "Jugador3":
		$FichaC31/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC31, true)
	else:
		$FichaC41/ficha.mover_ficha(dado1.frame, dado2.frame, $FichaC41, true)
