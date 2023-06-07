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
func _ready():
	nodo_game_master = $GameMaster
	print(nodo_game_master)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	lanzar_dados()
func _on_BDado1_pressed():
	Bdado1()
func _on_BDado2_pressed():
	Bdado2()
func lanzar_dados():
	# Obtener una referencia a los nodos AnimatedSprite de los dados
	var dado1 = get_node("Dado1")
	var dado2 = get_node("Dado2")

	# Seleccionar un frame aleatorio para cada dado
	var frame_dado1 = round(rand_range(0, 5))
	var frame_dado2 = round(rand_range(0, 5))
	# Establecer el frame seleccionado para cada dado
	dado1.frame = frame_dado1
	dado2.frame = frame_dado2

	
func Bdado1():
	if nodo_game_master.obtenerJugador() == "Jugador1":
		$FichaC11/ficha.mover_ficha(frame_dado1,frame_dado2, $FichaC11)
func Bdado2():
	if nodo_game_master.obtenerJugador() == "Jugador1":
		$FichaC11/ficha.mover_ficha(frame_dado1,frame_dado2, $FichaC11)
	#if frame_dado1 == frame_dado2:
			#$Jugador1.mover_ficha()
	
	#if nodo_game_master.obtenerJugador() == "Jugador1":
	#	$FichaC11/ficha.mover_ficha(frame_dado1, frame_dado2, $FichaC11)
	#elif nodo_game_master.obtenerJugador() == "Jugador2":
	#	if frame_dado1 == frame_dado2:
	#		$Jugador2.fichas_en_casa()
	#	$FichaC21/ficha.mover_ficha(frame_dado1, frame_dado2, $FichaC21)
	#elif nodo_game_master.obtenerJugador() == "Jugador3":
	#	$FichaC31/ficha.mover_ficha(frame_dado1, frame_dado2, $FichaC31)
	#else:
	#	$FichaC41/ficha.mover_ficha(frame_dado1, frame_dado2, $FichaC41)
		



