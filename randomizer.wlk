import wollok.game.*
import geografia.*

object randomizer {
		
	method position() {
		return 	
			new MiPosicion(x = (1..13).anyOne(), y = (1..10).anyOne()) 
	}
	
	method emptyPosition() {
		const pos = self.position()
		return if (direcciones.estaVacio(pos) && !direcciones.frenteALaPuerta(pos)) {
			pos
		} else {self.position()}
	}
}