import wollok.game.*
import direcciones.*
import armas.*
import extras.*

object jill {
	
	var property position = game.at(3,0)
	var property orientacion = derecha
	var property nroDeImagenActual = 1
	var estaDisparando = false
	const vidas = [vida1, vida2, vida3]
	
	method tamanio() {
		return if (position.y() == 0) {""} else {"-chica"}
	}
	
	method image() {
		if (estaDisparando) {
			return "jill" + "-disparando" + orientacion.sufijo() + self.tamanio() + ".png"
		}	else {
				return "jill" + orientacion.sufijo() + "-" + nroDeImagenActual + self.tamanio() +  ".png"
			}
	}
	
	method refrescarImagen() {
		if (nroDeImagenActual < 3) {nroDeImagenActual += 1}
			else {nroDeImagenActual = 1}
	}
	
	method reorientar(direccion) {
		if (direccion.sufijo() != "") {orientacion = direccion}
	}
	
	method puedeMoverHorizontal(direccion) {
		return (
			direccion.siguienteDesde(position).x() >= 0 &&
				direccion.siguienteDesde(position).x() <= 8)
	}	
	
	method moverHorizontal(direccion) {
		if (self.puedeMoverHorizontal(direccion)) {
			self.position(direccion.siguienteDesde(position));
		}
		self.reorientar(direccion);
	}
	
	method puedeMoverVertical(direccion) {
		return (
			direccion.siguienteDesde(position).y() >=0 &&
				direccion.siguienteDesde(position).y() <= 1
		)
	}
	
	method moverVertical(direccion) {
		if (self.puedeMoverVertical(direccion)) {
			self.position(direccion.siguienteDesde(position))
		}
	}
	
	method disparar(municion) {
		estaDisparando = true;
		municion.dispararse();
		game.schedule(200,{=>estaDisparando = false});
	}
	
	method murio() {
		return vidas.isEmpty()
	}
	
	method perderUnaVida() {
		if (!self.murio()) {
			vidas.remove(vidas.last())
		}
	}
	
	method mostrarVidas() {
		if (!self.murio()) {
			vidas.forEach({vida => game.addVisual(vida)})
		}
	}
}



object zombie1 {
	
	var property position = game.at(7,0);
	var property nroDeImagenActual = 1
	
	method image() {
		return "zombie1-" + nroDeImagenActual + ".png"
	}
	
	method refrescarImagen() {
		if (nroDeImagenActual < 3) {nroDeImagenActual += 1}
			else {nroDeImagenActual = 1}
	}
	
	method puedeMover(direccion) {
		return direccion.siguienteDesde(position).x() >= 0
	}
	
	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			self.position(direccion.siguienteDesde(position));
		}
	}
}
