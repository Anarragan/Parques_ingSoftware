extends Node

var nombre = get_name()  # Nombre del jugador
var fichas = [$FichaC11]  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador
var fichasAfuera = false # Esto nos indica que todas la fichas (disponibles) del jugador estan afuera
var contDadosUsados =  0 # Nos indica si el jugador yausó los dos dados


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

# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre
	
func getFichasAfuera():
	return fichasAfuera

func setfichasAfuera(value):
	fichasAfuera = value
	return fichasAfuera

func getContDadosUsados():
	return contDadosUsados

func SetContDadosUsados(val):
	contDadosUsados = val

