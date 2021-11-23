import wollok.game.*
import geografia.*
import armas.*
import misc.*

object personaje {
	
	var property position = new MiPosicion(x=3, y=6)
	var property orientacion = derecha
	var property vida = 12
	var property arma = manos

	
	method image()= "pj" + arma.sufijo() + orientacion.sufijo() + ".png"
	
	method puedeMover(direccion) {
		return direcciones.estaLibre(direccion.siguiente(position))
	}
	
	method mover(direccion) { 
		if (self.puedeMover(direccion)) {
			direccion.avanzarUno(position)
		}
		orientacion = direccion
	}
	
	method posicionEnfrente() {
		return orientacion.siguiente(position)
	}
	
	method fuerzaDeAtaque() {
		return arma.danio()
	}
	
	method atacar() {
		arma.activarAtaque()
	}
	
	method agarrarItem() {
		game.getObjectsIn(self.posicionEnfrente()).forEach({item => item.serAgarrado()})
	}
	
	method equiparArma(_arma) {
		arma.arrojarse()
		arma = _arma
		game.removeVisual(_arma)
	}
	
	method verificarVida() {
		if (vida === 0) {self.morir()}
	}
	
	method morir() {
		game.addVisualIn(personajeMuerto, position)
		game.removeVisual(self)		
	}

	method restarVida(_danio){
		vida = 0.max(vida - _danio)
	}

    method retrocederSiPuede(direccion) {
    	if (self.puedeMover(direccion)){
    		position = direccion.siguiente(position)
    	}
    }
    
	method recibirDanio(_danio, direccion) {
		game.sound("danioPj.mp3").play()
		self.retrocederSiPuede(direccion)	
		self.restarVida(_danio)
		self.verificarVida()
	}
	
}

object personajeMuerto {
	method image() = "personajeMuerto.png"
}
