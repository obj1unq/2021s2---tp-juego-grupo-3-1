import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
import decorado.*
import configuraciones.*
import musica.*
import inicio.*
import misc.*
import randomizer.*

class Nivel {
	var enemigosDerrotados = 0
	
	method iniciar() {
		game.clear()
		config.teclado()
		self.agregarFondo()
		game.addVisual(personaje)
		game.addVisual(vidaPj)
		self.agregarItems()
		self.agregarEnemigos(5)
		self.agregarDecoracion(5)
		self.agregarPuerta()
	}
	
	method agregarEnemigos(cantidad) {
		fabricaDeEnemigos.crearEnemigosAleatorios(cantidad)
		fabricaDeEnemigos.dibujarTodos()
		fabricaDeEnemigos.activarExploracionDeTodos()
	}

	method siguienteNivel() {}
	

	method agregarDecoracion(cantidad){
		cantidad.times({ x => game.addVisual(self.obtenerDecoracion()) })
	}

	method agregarItems() {}

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
		game.addVisualIn(rama, randomizer.emptyPosition())
		game.addVisualIn(arco, randomizer.emptyPosition())
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
//
//	override method siguienteNivel() {
//		super()
//		nivel3.iniciar()
//	}

}
//
//object nivel3 inherits Nivel {
//	override method agregarFondo(){
//		fondo.image("background2.jpg")
//		super()
//	}
//
//	override method obtenerNombreAleatorio(){
//		return "madera" + 0.randomUpTo(7).roundUp().toString() + ".png"
//	}
//
//	override method siguienteNivel() {
//		super()
//		nivel4.iniciar()
//	}
//}
//
//object nivel4 inherits Nivel {
//	override method agregarFondo(){
//		fondo.image("background.jpg")
//		super()
//	}
//
//
//	override method agregarPuerta(){
//		// sin puerta
//	}
//}