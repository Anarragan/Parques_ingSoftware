extends Node

var nombre = get_name()  # Nombre del jugador
var fichas = ["FichaC21", "FichaC22"]  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador
var posiciones_casa = [$Casa21, $Casa22]
var nodo_game_master = null


func _ready():
	nodo_game_master = get_node("../GameMaster")
	print(nodo_game_master)


# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre
	
func fichas_en_casa():
	for ficha in fichas:
		var nodo_ficha = get_node("../"+ ficha +"/ficha")
		if nodo_ficha.estado_salida() == false:
			nodo_ficha.salir_a_casa()
			print(nodo_game_master)
			nodo_game_master.cambiar_anuncio("Sacar Fichas de Casa")
