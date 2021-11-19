import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
import decorado.*
import configuraciones.*
import musica.*
import inicio.*

class Nivel {
	var enemigosDerrotados = 0
	
	method iniciar() {
		game.clear()
		config.teclado()
		self.agregarFondo()
		game.addVisual(personaje)
		self.agregarItems()
		self.agregarEnemigos()
		self.agregarDecoracion(5)
		self.agregarPuerta()
	}

	method siguienteNivel() {
		self.validarEnemigos()
	}
	
	method validarEnemigos(){
		if(enemigosDerrotados < self.cantidadDeEnemigos()){
			self.error("Falta derrotar enemigos")
		}
	}
	method agregarDecoracion(cantidad){
		cantidad.times({ x => game.addVisual(self.obtenerDecoracion()) })
	}

	method agregarEnemigos() {
		creadorDeEnemigos.dibujarEnemigos(self.cantidadDeEnemigos())
		creadorDeEnemigos.moverATodos()
	}
	method agregarItems() {}

	method agregarPuerta(){
		puerta.nivelActual(self)
		game.addVisual(puerta)
	}

	method agregarFondo(){
		game.addVisual(fondo)
	}

	method obtenerDecoracion(){
		return new Decorado(
			image = self.obtenerNombreAleatorio(),
			position = self.posicionAleatoria()
		)
	}

	method obtenerNombreAleatorio(){
		return "cripta" + 0.randomUpTo(7).roundUp().toString() + ".png"
	}

	method posicionAleatoria(){
		return game.at(1.randomUpTo(10), 1.randomUpTo(10))
	}
	
	method cantidadDeEnemigos(){
		return 3
	}
	
	method derrotarEnemigo(){
		enemigosDerrotados += 1
	}
}

object nivel1 inherits Nivel {
	var property comenzoElJuego = false
	
	method mostrarInicio() {
		pantallaDeInicio.mostrar()
		game.schedule(1000, {=>musica.loopear(musica.pantallaInicio())})
		keyboard.enter().onPressDo({
			if (!self.comenzoElJuego()) {
				musica.pantallaInicio().stop()
				musica.loopear(musica.nivel1())
				self.iniciar()}})				
	}
		
	override method agregarItems(){
		game.addVisual(rama)
		game.addVisual(arco)
	}

	override method siguienteNivel() {
		super()
		nivel2.iniciar()
	}
}

object nivel2 inherits Nivel {
	override method agregarFondo(){
		fondo.image("background3.jpg")
		super()
	}

	override method obtenerNombreAleatorio(){
		return "ruinas" + 0.randomUpTo(9).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		super()
		nivel3.iniciar()
	}

	override method cantidadDeEnemigos(){
		return 1
	}
}

object nivel3 inherits Nivel {
	override method agregarFondo(){
		fondo.image("background2.jpg")
		super()
	}

	override method obtenerNombreAleatorio(){
		return "madera" + 0.randomUpTo(7).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		super()
		nivel4.iniciar()
	}
}

object nivel4 inherits Nivel {
	override method agregarFondo(){
		fondo.image("background.jpg")
		super()
	}

	override method agregarEnemigos(){
		// Agregar boss
	}

	override method agregarPuerta(){
		// sin puerta
	}
}