import wollok.game.*
import enemigos.*
import personaje.*
import geografia.*
import armas.*
import decorado.*
import configuraciones.*
import musica.*
import misc.*
import randomizer.*

class Nivel {

	method iniciar() {
		game.clear()
		config.teclado()
		self.agregarFondo()
		game.addVisual(personaje)
		game.addVisual(vidaPj)
		self.agregarPuerta()
		self.agregarItems()
		self.agregarEnemigos(5)
		self.agregarDecoracion(5)
	}
	
	method agregarEnemigos(cantidad) {
		fabricaDeEnemigos.crearEnemigosAleatorios(cantidad)
		fabricaDeEnemigos.dibujarTodos()
		fabricaDeEnemigos.activarExploracionDeTodos()
	}

	method siguienteNivel() {
		monitor.mostrarPantallaDeCarga()
	}
	

	method agregarDecoracion(cantidad){
		cantidad.times({ x => game.addVisual(self.obtenerDecoracion()) })
	}

	method itemsDelNivel() {
		return [rama]
	}	
		
	method agregarItems() {
		self.itemsDelNivel().forEach({item => if (item != personaje.arma()){
											  game.addVisual(item)
											  monitor.itemsEnJuego().add(item)}
		})
	}
		
	method agregarPuerta(){
		puerta.nivelActual(self)
		puerta.cerrar()
		game.addVisual(puerta)
	}

	method agregarFondo(){
		game.addVisual(fondo)
	}

	method obtenerDecoracion(){
		return new Decorado(
			image = self.obtenerNombreAleatorio(),
			position = randomizer.emptyPosition()
		)
	}

	method obtenerNombreAleatorio(){
		return "cripta" + 0.randomUpTo(7).roundUp().toString() + ".png"
	}
	
}

object nivel1 inherits Nivel {
	
	override method siguienteNivel() {
		//super()
		//game.schedule(2500, {=>nivel2.iniciar()})
		nivel2.iniciar()
	}
}

object nivel2 inherits Nivel {
	
	override method itemsDelNivel() {
		return super() + [arco]
	}
	
	override method agregarFondo(){
		fondo.image("background3.jpg")
		super()
	}

	override method obtenerNombreAleatorio(){
		return "ruinas" + 0.randomUpTo(9).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		super()
		game.schedule(2500, {=>nivel3.iniciar()})
	}

}

object nivel3 inherits Nivel {
	
	override method itemsDelNivel() {
		return super() + [arco, baculo]
	}
	override method agregarFondo(){
		fondo.image("background2.jpg")
		super()
	}

	override method obtenerNombreAleatorio(){
		return "madera" + 0.randomUpTo(7).roundUp().toString() + ".png"
	}

	override method siguienteNivel() {
		super()
		game.schedule(2500, {=>nivel4.iniciar()})
	}
}

object nivel4 inherits Nivel {
	
	override method itemsDelNivel() {
		return super() + [arco, baculo]
	}
	
	override method agregarFondo(){
		fondo.image("background4.jpg")
		super()
	}


	override method agregarPuerta(){
		// sin puerta
	}
}