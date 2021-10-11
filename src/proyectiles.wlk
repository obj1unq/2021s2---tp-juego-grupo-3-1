import wollok.game.*
import direcciones.*

object cargaDeProyectiles{
	// siempre tiene 1 proyectil
	var property _proyectil = #{proyectil}
	
	method lanzaMisilDesdeLa(nave){
		
		_proyectil.forEach({bala => bala.disparateDesde(nave)})
		self.cambiaDeBala()
	
	}
		// como cada proyectil tiene un numero de serie, mapeo dicho num y lo somo con cero para tener el num y manipularlo
	method numSerie(){
		return _proyectil.map({bala => bala.serie()}).sum() + 0
	}

//los num de serie siempre van a ser 0 o 1 ya que contamos con 2 balas
	method cambiaDeBala(){
		if(self.numSerie() == 0){
			_proyectil.remove(proyectil)
			_proyectil.add(proyectil1)
		}else{ _proyectil.remove(proyectil1);_proyectil.add(proyectil)}
	}
	
}
object proyectil{
	var property position = game.at(-5,-8)
	const property serie = 0
	
	method image(){
		return "disparo.png"	
	}
	
	method saleDisparado(){
		//if (position.x() > 0) {	
			position = position.right(1)  
		//}
	}
	
	method disparateDesde(nave){
		position = nave.position().right(1)
		
	}
	method impactado(algo){
		position = game.at(-5,-8)
		algo.impactado(self)
	}
	
}
object proyectil1{
	var property position = game.at(-5,-9)
	const property serie = 1
	
	method image(){
		return "disparo.png"	
	}
	
	method saleDisparado(){
		//if (position.x() > 0) {	
			position = position.right(1)  
		//}
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