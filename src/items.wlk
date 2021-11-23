import wollok.game.*
import personaje.*
class Item{
	var property position
	const vidaQueOtorga = 3
	method image(){
		return "posion.png"
	}
	
	method serAgarrado() {
		game.removeVisual(self)
		self.regenerarVida(personaje)
		
	}
	
	method regenerarVida(persona){
		persona.recuperarVida(vidaQueOtorga)
	}
	//polimorfismo
	method recibirDanio(danio, direccion){}
}
