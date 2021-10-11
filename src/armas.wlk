import wollok.game.*
import characters.*

object balaDeJill {
	
	var property position;
	var sentido;
	
	method image() {
		return "bala" + jill.orientacion().sufijo() + jill.tamanio() + ".png"
	}
	
	method mover(direccion) {
		self.position(direccion.siguienteDesde(position))
	}

	method estaEnElJuego() {
		return game.allVisuals().contains(self)
	}	
	
	method sePerdio() {
		return self.estaEnElJuego() && (position.x() > 8 || position.x() < 0)
	}
	
	method borrarSiSePerdio() {
		if (self.sePerdio()) {
			game.removeVisual(self)
		}
	}
	
	method aparecer() {
		if (self.estaEnElJuego()) {
			game.removeVisual(self);
		}
		game.addVisual(self);
	}
	
	method dispararse() {
		self.position(jill.orientacion().siguienteDesde(jill.position()))
		self.aparecer()
		sentido = jill.orientacion()
		game.onTick(400, "Movimiento bala de Jill", {=>
			self.mover(sentido)
			self.borrarSiSePerdio()
		})				
	}
}