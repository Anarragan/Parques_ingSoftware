extends Sprite


# TO DO: lo ideal es hacer un algoritmo en la que se iteré por todos las posibles enemigos de
# la ficha. Esto para los caso en la que puede comer 2, 3 o mas ficha enemigas a la vez.

# To DO: Cada ficha tendra respectivamente su posicion inicial = 1 (que sera la casilla de salida respectiva)
# y su casilla final (contar cuantas casillas hay hasta el final, se supone que es igual para todos) que es la meta

# TO DO: Hacer que cuando las fichas se interpolen (se pongan una "encima" de la otra) entonces estas
# "hallan" una forma de acoodarse a lo largo de la casilla en la que estan

# TO DO: Cuando la ficha llegue a la meta, esta queda "inhabilitada". es decir ya no esta disponible para mover


var salida = false
var jugador = null
#var posicion_inicial = Vector2(65, 546)
var casa_ficha = 1

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
		comer_ficha(position_ficha.position)
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
		comer_ficha(position_ficha.position)

func comer_ficha(posicion_final):
	# obtenemos los nodos de las fichas enemigas
	for f in range(1, 5):
		if f == casa_ficha:
			continue
		for i in range(1, 5):
			#print(f, i)
			var ficha_enemiga = get_node("../../FichaC" + str(f) + str(i))
			
			# Este codigo se quita cuando ya este todas las fichas cargadas:
			if (f == 1 or f == 3 or f == 4)  and i > 1:
				break
			elif f == 2 and i > 2:
				break
			
			# Si la posicion  del puntero de la ficha enemiga es igual a a la posicion de la ficha
			# entonces la ficha enemiga retorna a su casa a su posicion inicial
			if ficha_enemiga.global_position == posicion_final:
				# Hacer desaparecer la ficha enemiga
				#ficha_enemiga.queue_free()
				# Mover la ficha actual a la posición final
				var tween = ficha_enemiga.get_child(1)
				var casa_enemiga = get_node("../../Casa" + str(f) + str(i))
				tween.interpolate_property(ficha_enemiga, "position", ficha_enemiga.position, casa_enemiga.position, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
				yield(tween, "tween_completed")
