import wollok.game.*
import personaje.*
import enemigos.*
import decorado.*
import geografia.*
import niveles.*
import musica.*
import armas.*

object vidaPj {
	const property position = new MiPosicion(x = 0, y = 11)
	method image() = "vidaPj" + personaje.vida() + ".png"
}

object avisoPuerta {
	const property position = new MiPosicion(x = 8, y = 10)
	method image() = "avisoPuerta.png"

	method mostrarse() {
		if (!monitor.estaEnElJuego(self)) {
			game.addVisual(self)
			game.schedule(2000, {=>
			game.removeVisual(self)})
		}			
	}
	
	//polimorfismo
	method serAgarrado(){}
	method recibirDanio(danio, direccion) {}
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
		keyboard.enter().onPressDo({game.removeTickEvent("Titilar game over");nivel1.iniciar()})
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
	
	method limpiarItems() {
		itemsEnJuego.forEach({item => if (monitor.estaEnElJuego(item)){game.removeVisual(item)}})
		itemsEnJuego.clear()
	}
}

class Pantalla {
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
	
	//polimorfismo
	method recibirDanio(danio, direccion) {}
	method serAgarrado() {}
}

const pantallaDeInicio = new Pantalla(position = new MiPosicion(x=2,y=2),
									  nombre = "inicio")
const pantallaGameOver = new Pantalla(position = new MiPosicion(x=3,y=4),
									  nombre = "gameOver")
									  
									  
									  