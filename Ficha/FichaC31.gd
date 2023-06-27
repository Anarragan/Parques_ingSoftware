extends Sprite




# To DO: Cada ficha tendra respectivamente su posicion inicial = 1 (que sera la casilla de salida respectiva)
# y su casilla final (contar cuantas casillas hay hasta el final, se supone que es igual para todos) que es la meta

# TO DO: Hacer que cuando las fichas se interpolen (se pongan una "encima" de la otra) entonces estas
# "hallan" una forma de acoodarse a lo largo de la casilla en la que estan

# TO DO: Cuando la ficha llegue a la meta, esta queda "inhabilitada". es decir ya no esta disponible para mover

#como estamos en prueba salida es true
var salida = false
var jugador = null
var casa_ficha = null
var numero_ficha = null
var nodo_game_master = null
var posicion_actual = 35
const salidaCasa = 35



func _ready():
	nodo_game_master = get_node("../../GameMaster")
	jugador = get_node("../../Jugador3")
	# Acceder al nodo padre para luego obetner cual es su casa y numero para definir 
	# que tipo de ficha es la que se mueve o comienza a interactuar
	var nombrepParentNode = get_parent().get_name()
	casa_ficha = nombrepParentNode[-2]
	numero_ficha = nombrepParentNode[-1]
	print(casa_ficha, numero_ficha)
	

func salio_de_casa():
	salida = true

func ficha_a_casa():
	salida = false
	posicion_actual = 35

func getJugador():
	return jugador

func getSalidaCasa():
	return salidaCasa

func getPosicion_actual():
	return posicion_actual

func sacar_ficha(dado1_valor, dado2_valor, position_ficha):
	nodo_game_master.cambiar_anuncio("No hay Anuncios")
	# Si los dados tienen el mismo valor, mueve la ficha
	# Esto aplica cuando una ficha esta en la casa, para sacarla 
	# Restablecer los intentos y lanzamientos restantes cuando se mueve una ficha

	
	var tween = position_ficha.get_node("MovimientoC" + casa_ficha + numero_ficha)
	if dado1_valor == dado2_valor and !(salida):
		# Obtiene la posición final de la casilla correspondiente
		var posicion_final = get_node("../../Casilla"+str(posicion_actual)).get_global_position()
		
		# Crea una interpolación Tween para mover la ficha
		#var tween = position_ficha.get_node("MovimientoC11")
		tween.interpolate_property(position_ficha, "position", position_ficha.position, posicion_final, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		# Cambiamos el valor de salida dado que ya la ficha salio de la casa y ademas verificamos
		# si esta come
		salio_de_casa()
		jugador.setfichasAfuera(true)

		if !(comer_ficha(position_ficha.position)):
			nodo_game_master.cambiarTurno()
			nodo_game_master.cambiar_anuncio("No hay Anuncios")
	
	else: 	
		if jugador.getTresTurnos() >= 3:
			if jugador.getUsarTresTurnos():
				jugador.setReiniciarTresTurnos()
			nodo_game_master.cambiarTurno()
			nodo_game_master.cambiar_anuncio("No hay Anuncios")
		elif !jugador.getUsarTresTurnos():
			nodo_game_master.cambiarTurno()
			nodo_game_master.cambiar_anuncio("No hay Anuncios")
		else:
			jugador.setTresTurnosAumentar()

func mover_ficha(dado1_valor, dado2_valor, position_ficha, dadoDerecho):
	if salida:
		nodo_game_master.cambiar_anuncio("No hay Anuncios")
		# Si los dados tienen el mismo valor, mueve la ficha
		# Esto aplica cuando una ficha esta en la casa, para sacarla 
		# Restablecer los intentos y lanzamientos restantes cuando se mueve una ficha
		var tween = position_ficha.get_node("MovimientoC" + casa_ficha + numero_ficha)
		var posicion_final 
		if !dadoDerecho:
			posicion_final = posicion_actual + dado1_valor + 1
		else:
			posicion_final = posicion_actual + dado2_valor + 1

		for i in range(posicion_actual+1, posicion_final+1):
			var casilla_actual = get_node("../../Casilla"+str(posicion_actual))
			var siguiente_casilla = get_node("../../Casilla"+str(i % 68 + 1))  # Calcula la casilla siguiente utilizando el operador de módulo (%)
			tween = position_ficha.get_node("MovimientoC" + casa_ficha + numero_ficha)
			tween.interpolate_property(position_ficha, "position", casilla_actual.get_global_position(), siguiente_casilla.get_global_position(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			posicion_actual = i % 68 + 1  # Actualiza la posición actual utilizando el operador de módulo (%)
			yield(tween, "tween_completed")
		
		jugador.SetContDadosUsados(jugador.getContDadosUsados() + 1)
		var comio = comer_ficha(position_ficha.position)
		
		if dado1_valor == dado2_valor or comio:
			nodo_game_master.cambiar_anuncio("Vuelve a lanzar!")
			jugador.SetContDadosUsados(0)
		elif jugador.getContDadosUsados() == 2:
			nodo_game_master.cambiarTurno()
			nodo_game_master.cambiar_anuncio("No hay Anuncios")
			jugador.SetContDadosUsados(0)
	

func comer_ficha(posicion_final):
	var comio_fichas = false
	# obtenemos los nodos de las fichas enemigas
	for f in range(1, 5):
		if f == int(casa_ficha):
			continue
		for i in range(1, 5):
			var ficha_enemiga = get_node("../../FichaC" + str(f) + str(i))
			
			# Este codigo se quita cuando ya este todas las fichas cargadas:
			
			# Si la posicion  del puntero de la ficha enemiga es igual a a la posicion de la ficha
			# entonces la ficha enemiga retorna a su casa a su posicion inicial
			if ficha_enemiga.global_position == posicion_final:
				var casilla_enemiga = get_node("../../Casilla"+str(ficha_enemiga.get_child(0).getSalidaCasa()))
				
				# Ahora estos condicionales se usan para verificar si la ficha enemiga esta en una casilla
				# donde no puede ser "comida"
				# Caso 1: Casilla enemiga en casilla de su respectiva casa:
				if ficha_enemiga.global_position == casilla_enemiga.global_position:
					continue
				
				# Caso 2: Si esta en una casilla seguro
				var enemigoEnCasillaSeguro = false
				for casillaSeguro in nodo_game_master.getCasillasSeguro():
					if casillaSeguro == ficha_enemiga.get_child(0).getPosicion_actual():
						enemigoEnCasillaSeguro = true
						break
				if enemigoEnCasillaSeguro:
					enemigoEnCasillaSeguro = false
					continue
				# Hacer desaparecer la ficha enemiga
				#ficha_enemiga.queue_free()
				# Mover la ficha actual a la posición final
				var tween = ficha_enemiga.get_child(1)
				var casa_enemiga = get_node("../../Casa" + str(f) + str(i))
				tween.interpolate_property(ficha_enemiga, "position", ficha_enemiga.position, casa_enemiga.position, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
				yield(tween, "tween_completed")
				comio_fichas = true
				nodo_game_master.cambiar_anuncio("Lanzar Nuevamente")
				ficha_enemiga.get_child(0).ficha_a_casa()
				# Cuando es comida la ficha del jugador, entonces tiene la posibilidad de lanzar tre
				# veces hasta sacar ficha (estamos con una ficha por jugador, cuando se de 4 fichas se cambia lo logica)
				ficha_enemiga.get_child(0).getJugador().setReiniciarTresTurnos()
	return comio_fichas
