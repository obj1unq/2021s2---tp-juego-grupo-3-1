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
	method iniciar() {
		game.clear()
		config.teclado()
		game.addVisual(personaje)
		self.agregarItems()
		self.agregarEnemigos()
		self.agregarDecoracion()
		self.agregarPuerta()
	}

	method siguienteNivel() {}
	method agregarDecoracion() {}
	method agregarEnemigos() {
		creadorDeEnemigos.dibujarEnemigos(3)
		creadorDeEnemigos.moverATodos()
	}
	method agregarItems() {}

	method agregarPuerta(){
		puerta.nivelActual(self)
		game.addVisual(puerta)
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

	override method agregarDecoracion(){
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
	}

	override method siguienteNivel() {
		nivel2.iniciar()
	}
}

object nivel2 inherits Nivel {
	override method agregarDecoracion(){
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
	}

	method obtenerNombreAleatorio(){
		return "ruinas" + 0.randomUpTo(9).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		nivel3.iniciar()
	}
}

object nivel3 inherits Nivel {

	override method agregarDecoracion(){
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
	}

	method obtenerNombreAleatorio(){
		return "madera" + 0.randomUpTo(7).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		nivel4.iniciar()
	}
}

object nivel4 inherits Nivel {
	override method agregarDecoracion(){
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
		game.addVisual(self.obtenerDecoracion())
	}

	override method agregarEnemigos(){
		// Agregar boss
	}

	method agregarPuerta(){
		// sin puerta
	}
}