extends Node

var nombre = ""  # Nombre del jugador
var fichas = []  # Lista de fichas del jugador
var fichaSeleccionada = null  # Ficha seleccionada por el jugador

# Agregar una ficha al jugador
func agregarFicha(ficha):
	fichas.append(ficha)

# Establecer el nombre del jugador
func setNombre(nuevoNombre):
	nombre = nuevoNombre

# Obtener el nombre del jugador
func getNombre():
	return nombre

# Recibir los valores de los dados lanzados por el GameMaster
func recibirValoresDados(dado1Valor, dado2Valor):
	# Lógica para manejar los valores de los dados recibidos
	# Puedes implementar tu lógica aquí, por ejemplo, seleccionar la ficha a mover

# Mover la ficha seleccionada por el jugador
func moverFicha(ficha):
	if ficha in fichas:
		fichaSeleccionada = ficha
		# Lógica para mover la ficha seleccionada
		# Puedes implementar tu lógica aquí, por ejemplo, llamar a

