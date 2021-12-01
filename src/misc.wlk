import wollok.game.*
import personaje.*
import enemigos.*
import decorado.*
import geografia.*
import niveles.*
import musica.*
import armas.*
import configuraciones.*

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
	var property esElUltimoNivel = false

	method hayEnemigosRestantes() {
		return fabricaDeEnemigos.enemigosRestantes() > 0
	}
	
	method verificarNivel() {
		if (!self.hayEnemigosRestantes() && !esElUltimoNivel) {
			puerta.abrir()
		} else if (!self.hayEnemigosRestantes() && esElUltimoNivel) {
			portal.aparecer()
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
		keyboard.enter().onPressDo({game.schedule(500, {=>self.reiniciarJuego()})})
		keyboard.r().onPressDo({game.stop()})
	}
	
	method mostrarInicio() {
		pantallaDeInicio.mostrar()
		game.onTick(800, "Titilar inicio", {=> pantallaDeInicio.titilar()})
		game.schedule(500, {=>musica.loopear(musica.pantallaInicio())})
		keyboard.enter().onPressDo({
				game.removeTickEvent("Titilar inicio")
				musica.pantallaInicio().stop()
				musica.loopear(musica.general())
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
		esElUltimoNivel = false
		personaje.reiniciar()
		direcciones.initialize()
		if (musica.nivelFinal().played()) {musica.detener(musica.nivelFinal())}
		nivel1.iniciar()
		if (!musica.general().played()) {game.schedule(500, {=>musica.loopear(musica.general())})}
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
	
	method ocultar() {
		game.removeVisual(self)
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
}										
					
object portal inherits Polimorfi {
	const property position = new MiPosicion(x=7, y=6)
	var num = 1
	var creciendo = true
	
	method image() = "portal" + num + ".png"
	
	method animar() {
		game.onTick(150, "Animacion de portal", {=>
			if (creciendo && num < 9) {
				num += 1
			} else if (!creciendo && num > 1) {
				num -= 1
			} else if (!creciendo && num == 1) {
				creciendo = true
			} else {creciendo = false}
		})
	} 
	
	method detenerAnimacion() {
		game.removeTickEvent("Animacion de portal")
	}
	
	method nivelFinal() {
		game.clear()
		musica.detener(musica.general())
		musica.loopear(musica.nivelFinal())
		config.teclado()
		fondoBoss.mostrar()
		fondoBoss.titilar()
		direcciones.actualizarBordesParaNivelFinal()
		personaje.position(new MiPosicion(x=7, y= 0))
		game.addVisual(personaje)	
		game.addVisual(vidaPj)	
		mensajeBoss.aparecer()
	}
	
	method aparecer() {
		game.sound("nivelCompletado.mp3").play()
		game.addVisual(self)
		self.animar()
	}
	
	override method serAgarrado() {
		self.nivelFinal()
	}
	
}

object fondoBoss inherits Pantalla(position = new MiPosicion(x=0,y=0), nombre = "fondoBoss") {
	var subiendo = true

	override method titilar() {
		game.onTick(750, "Animacion de fondoBoss", {=>
 		  if (subiendo && num < 20) {
			num += 1
	 	  } else if (!subiendo && num > 1) {
			num -= 1
	      } else if (!subiendo && num == 1) {
			subiendo = true
	      } else {subiendo = false}})
	}
}				 

object mensajeBoss {
	const property position = new MiPosicion(x=5,y=7)
	
	method image() = "mensajeBoss.png"
	
	method aparecer() {
		boss.aparecer()
		game.addVisual(self)
		game.schedule(2000, {=>
			game.removeVisual(self)
			boss.animar()
		})
	}
	
}
			
						  
									  