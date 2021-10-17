import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
import decorado.*
import configuraciones.*

class Nivel {
	method iniciar() {
		game.clear()
		config.teclado()
		game.boardGround("background.jpg")
		game.addVisual(personaje)
		self.agregarItems()
		self.agregarEnemigos()
		self.agregarDecoracion()
		self.agregarPuerta()
	}

	method siguienteNivel() {}
	method agregarDecoracion() {}
	method agregarEnemigos() {}
	method agregarItems() {}
	
	method obtenerDecoracion(){
		return new Decorado(
			image = self.obtenerNombreAleatorio(),
			position = self.posicionAleatoria()
		)
	}

	method agregarPuerta(){
		puerta.nivelActual(self)
		game.addVisual(puerta)
	}

	method obtenerNombreAleatorio(){
		return "tumba" + 1.randomUpTo(3).roundUp().toString() + ".png"
	}

	method posicionAleatoria(){
		return game.at(1.randomUpTo(10), 1.randomUpTo(10))
	}
}

object nivel1 inherits Nivel {
	override method agregarItems(){
		game.addVisual(rama)
	}

	override method agregarDecoracion(){
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
	}

	override method agregarEnemigos(){
		creadorDeEnemigos.dibujarBichos()
		creadorDeEnemigos.moverATodos()
	}

	override method siguienteNivel() {
		nivel2.iniciar()
	}
}

object nivel2 inherits Nivel {
}