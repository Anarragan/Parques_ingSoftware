extends Sprite


# TO DO: lo ideal es hacer un algoritmo en la que se iteré por todos las posibles enemigos de
# la ficha. Esto para los caso en la que puede comer 2, 3 o mas ficha enemigas a la vez.


var salida = false
var posicion_inicial = Vector2(65, 546)

func _ready():
	pass

func salio_de_casa():
	salida = true
var posicion_actual = 1	


func mover_ficha(dado1_valor, dado2_valor, position_ficha):
	# Si los dados tienen el mismo valor, mueve la ficha
	# Esto aplica cuando una ficha esta en la casa, para sacarla 
	
	var tween = position_ficha.get_node("MovimientoC11")
	if dado1_valor == dado2_valor and !(salida):
		# Obtiene la posición final de la casilla correspondiente
		var posicion_final = get_node("../../Casilla1").get_global_position()
		
		# Crea una interpolación Tween para mover la ficha
		#var tween = position_ficha.get_node("MovimientoC11")
		tween.interpolate_property(position_ficha, "position", position_ficha.position, posicion_final, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		# Cambiamos el valor de salida dado que ya la ficha salio de la casa y ademas verificamos
		# si esta come
		salio_de_casa()
		comer_ficha(position_ficha.position, 2)
	elif salida:
		# Si la ficha ya esta afuera de la casa, entonces se mueve por la casillas
		# de acuerdo al numero de un dado o dos (por ahora los dos)
		var posicion_final = posicion_actual + dado1_valor + dado2_valor + 2

		# Mueve la ficha en cada casilla una por una hasta llegar a la casilla final
		for i in range(posicion_actual+1, posicion_final+1):
			# Obtiene la casilla actual y la siguiente casilla a moverseMovimientoC11
			var casilla_actual = get_node("../../Casilla"+str(posicion_actual))
			var siguiente_casilla = get_node("../../Casilla"+str(i))

		# Crea una interpolación Tween para mover la ficha a la siguiente casilla
			#var tween = get_node("../MovimientoC11")
			tween.interpolate_property(position_ficha, "position", casilla_actual.get_global_position(), siguiente_casilla.get_global_position(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()

			# Actualiza la posición actual de la ficha
			posicion_actual = i

			# Espera a que la interpolación Tween termine antes de continuar
			yield(tween, "tween_completed")
		# Luego de llegar a su ultima casilla correspondiente vemos si pude comer a otra ficha
		comer_ficha(position_ficha.position, 1)

func comer_ficha(posicion_final, i):
	# obtenemos el nodo de la ficha enemiga
	var ficha_enemiga = get_node("../../FichaC2" + str(i))
	# Si la posicion  del puntero de la ficha enemiga es igual a a la posicion de la ficha
	# entonces la ficha enemiga retorna a su casa a su posicion inicial
	if ficha_enemiga.global_position == posicion_final:
		# Hacer desaparecer la ficha enemiga
		#ficha_enemiga.queue_free()
		# Mover la ficha actual a la posición final
		var tween = ficha_enemiga.get_child(1)
		var casa_enemiga = get_node("../../Casa2" + str(i))
		tween.interpolate_property(ficha_enemiga, "position", ficha_enemiga.position, casa_enemiga.position, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
