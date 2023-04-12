extends Sprite

var salida = false

func _ready():
	pass

func salio_de_casa():
	salida = true
var posicion_actual = 1	


func mover_ficha(dado1_valor, dado2_valor, position_ficha, casilla_nodo):
	# Si los dados tienen el mismo valor, mueve la ficha
	if dado1_valor == dado2_valor and !(salida):
		# Obtiene la posición final de la casilla correspondiente
		var posicion_final = casilla_nodo.get_global_position()
		
		# Crea una interpolación Tween para mover la ficha
		var tween = position_ficha.get_node("MovimientoC11")
		tween.interpolate_property(position_ficha, "position", position_ficha.position, posicion_final, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		salio_de_casa()
		comer_ficha(position_ficha.position, 2)
	elif salida:
		
		var posicion_final = posicion_actual + dado1_valor + dado2_valor + 2

		# Mueve la ficha en cada casilla una por una hasta llegar a la casilla final
		for i in range(posicion_actual+1, posicion_final+1):
			# Obtiene la casilla actual y la siguiente casilla a moverseMovimientoC11
			var casilla_actual = get_node("../../Casilla"+str(posicion_actual))
			var siguiente_casilla = get_node("../../Casilla"+str(i))

		# Crea una interpolación Tween para mover la ficha a la siguiente casilla
			var tween = get_node("../MovimientoC11")
			tween.interpolate_property(position_ficha, "position", casilla_actual.get_global_position(), siguiente_casilla.get_global_position(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()

			# Actualiza la posición actual de la ficha
			posicion_actual = i

			# Espera a que la interpolación Tween termine antes de continuar
			yield(tween, "tween_completed")
		
		comer_ficha(position_ficha.position, 1)

func comer_ficha(posicion_final, i):
	var ficha_enemiga = get_node("../../FichaC2" + str(i))
	if ficha_enemiga.global_position == posicion_final:
		# Hacer desaparecer la ficha enemiga
		#ficha_enemiga.queue_free()
		# Mover la ficha actual a la posición final
		var tween = ficha_enemiga.get_child(1)
		var casa_enemiga = get_node("../../Casa2" + str(i))
		tween.interpolate_property(ficha_enemiga, "position", ficha_enemiga.position, casa_enemiga.position, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")

