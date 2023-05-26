extends Node

var nombre = ""  # Nombre del jugador
var fichas = []  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador


# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre

# Recibir los valores de los dados lanzados por el GameMaster
func recibirValoresDados(dado1Valor, dado2Valor):
	# Lógica para manejar los valores de los dados recibidos
	# implementar lógica aquí, por ejemplo, seleccionar la ficha a mover
	return

# Mover la ficha seleccionada por el jugador
func moverFicha(ficha):
	if ficha in fichas:
		fichaSeleccionada = ficha
		return 
		# Lógica para mover la ficha seleccionada

