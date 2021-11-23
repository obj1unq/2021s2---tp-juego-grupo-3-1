import wollok.game.*

class Item{
	var property position
	
	method image(){
		return "posion.png"
	}
	
	method serAgarrado() {
		game.removeVisual(self)
	}
	
	//polimorfismo
	method recibirDanio(danio, direccion){}
}
