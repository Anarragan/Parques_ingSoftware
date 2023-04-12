extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	lanzar_dados()
	
func lanzar_dados():
	# Obtener una referencia a los nodos AnimatedSprite de los dados
	var dado1 = get_node("Dado1")
	var dado2 = get_node("Dado2")

	# Seleccionar un frame aleatorio para cada dado
	var frame_dado1 = round(rand_range(0, 5))
	var frame_dado2 = round(rand_range(0, 5))
	print(frame_dado1, frame_dado2)
	# Establecer el frame seleccionado para cada dado
	dado1.frame = frame_dado1
	dado2.frame = frame_dado2
	
	$FichaC11/ficha.mover_ficha(frame_dado1, frame_dado2, $FichaC11, get_node("Casilla1"))
