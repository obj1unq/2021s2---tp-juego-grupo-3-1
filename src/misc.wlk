import wollok.game.*
import personaje.*
import enemigos.*
import decorado.*
import geografia.*
import niveles.*
import musica.*
import armas.*

class Polimorfi {
	method serAgarrado() {}
	method recibirDanio(danio, direccion) {}
}

object vidaPj inherits Polimorfi {
	const property position = new MiPosicion(x = 9, y = 0)
	method image() = "vidaPj" + personaje.vida() + ".png"
}

object avisoPuerta inherits Polimorfi {
	const property position = new MiPosicion(x = 8, y = 10)
	method image() = "avisoPuerta.png"

	method mostrarse() {
		if (!monitor.estaEnElJuego(self)) {
			game.addVisual(self)
			game.schedule(2000, {=>
			game.removeVisual(self)})
		}			
	}
}


object monitor {

	const property itemsEnJuego = []

	method hayEnemigosRestantes() {
		return fabricaDeEnemigos.enemigosRestantes() > 0
	}
	
	method verificarNivel() {
		if (!self.hayEnemigosRestantes()) {
			puerta.abrir()
		}
	}

	method validarEnemigosRestantes(accion){
		if(self.hayEnemigosRestantes()) {
			avisoPuerta.mostrarse()
		} else {accion.apply()}
	}

	method estaEnElJuego(objeto) {
		return game.hasVisual(objeto)
	}

	method mostrarGameOver() {
		fabricaDeEnemigos.removerYBorrarTodos()
		self.limpiarItems()
		pantallaGameOver.mostrar()
		game.onTick(800, "Titilar game over", {=>pantallaGameOver.titilar()})
		keyboard.enter().onPressDo({self.reiniciarJuego()})
		keyboard.r().onPressDo({game.stop()})
	}
	
	method mostrarInicio() {
		pantallaDeInicio.mostrar()
		game.onTick(800, "Titilar inicio", {=> pantallaDeInicio.titilar()})
		game.schedule(500, {=>musica.loopear(musica.pantallaInicio())})
		keyboard.enter().onPressDo({
				game.removeTickEvent("Titilar inicio")
				musica.pantallaInicio().stop()
				musica.loopear(musica.nivel1())
				nivel1.iniciar()})				
	}
	
	method mostrarPantallaDeCarga() {
		pantallaDeCarga.mostrar()
		game.onTick(500, "Pantalla de carga", {=> pantallaDeCarga.titilar()})
		game.schedule(3000, {=>game.removeTickEvent("Pantalla de carga");
									pantallaDeCarga.ocultar()})
	}
	
	method reiniciarJuego() {
		game.removeTickEvent("Titilar game over")
		fondo.image("background.jpg")
		personaje.reiniciar()
		nivel1.iniciar()
	}
	
	method limpiarItems() {
		itemsEnJuego.forEach({item => if (monitor.estaEnElJuego(item)){game.removeVisual(item)}})
		itemsEnJuego.clear()
	}
}

class Pantalla inherits Polimorfi {
	const property position	
	var num = 1
	const nombre
	
	method image() = nombre + num + ".png"
	
	method titilar() {
		if (num == 1) {
			num = 2
		} else {num = 1}
	}
	
	method mostrar() {
		game.addVisual(self)
	}
}

const pantallaDeInicio = new Pantalla(position = new MiPosicion(x=2,y=2),
									  nombre = "inicio")
									  
const pantallaGameOver = new Pantalla(position = new MiPosicion(x=3,y=4),
									  nombre = "gameOver")
									  
object pantallaDeCarga inherits Pantalla(position = new MiPosicion(x=0,y=0),
										 nombre = "loading") {

	override method titilar() {
		if (num == 4) {
			num = 1
		} else {num += 1}
	}
	
	method ocultar() {
		game.removeVisual(self)
	}										 	
}										
									 
									  
									  