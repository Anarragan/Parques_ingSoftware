extends Node

var nombre = get_name()  # Nombre del jugador
var fichas = ["FichaC21", "FichaC22"]  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador
var posiciones_casa = [$Casa21, $Casa22]
var nodo_game_master = null
var contDadosUsados =  0
var fichasAfuera = false # Esto nos indica que todas la fichas (disponibles) del jugador estan afuera

# Esta parte es cuando todas sus fuchas disponibles estan en la casa y se necesita 
# lanzar tres veces el dado para sacarlas
var tresTurnos = 1
# pude usar tres turnos ?
var usarTresTurnos = true

func getTresTurnos():
	return tresTurnos
func getUsarTresTurnos():
	return usarTresTurnos
func setTresTurnosAumentar():
	tresTurnos += 1
func setReiniciarTresTurnos():
	tresTurnos = 1

func _ready():
	nodo_game_master = get_node("../GameMaster")
	print(nodo_game_master)


# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre
	
func getContDadosUsados():
	return contDadosUsados

func SetContDadosUsados(val):
	contDadosUsados = val
	
func fichas_en_casa():
	for ficha in fichas:
		var nodo_ficha = get_node("../"+ ficha +"/ficha")
		if nodo_ficha.estado_salida() == false:
			nodo_ficha.salir_a_casa()
			print(nodo_game_master)
			nodo_game_master.cambiar_anuncio("Sacar Fichas de Casa")

func getFichasAfuera():
	return fichasAfuera

func setfichasAfuera(value):
	fichasAfuera = value
	return fichasAfuera
