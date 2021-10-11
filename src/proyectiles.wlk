import wollok.game.*
import direcciones.*

object proyectil{
	var property position = game.at(-5,-8)
	
	method image(){
		return "disparo.png"	
	}
	
	method saleDisparado(){
		if (position.x() > 0) {	
			position = position.right(1)  
		}
	}
	
	method disparateDesde(nave){
		position = nave.position().right(1)
		
	}
	method impactado(algo){
		position = game.at(-5,-8)
		algo.impactado(self)
	}
	
}
object proyectilEnemigo{
	var property position = game.at(-9,-9)
	
	method image(){
		return "disparoEnemigo.png"	
	}
	
	method saleDisparado(){
		if (position.x() > 0) {
			position = position.left(1)  
		}
	}
	
	method disparateDesdeEnemigo(nave){
		position = nave.position().left(1)
		
	}
	
	method impactado(algo){
		position = game.at(-9,-9)
		
	}
	
	method remover(){
		game.removeVisual(self)
	}

}