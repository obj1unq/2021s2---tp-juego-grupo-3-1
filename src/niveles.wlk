import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
import decorado.*

object nivel1 {
	
	method iniciar() {
		game.addVisual(personaje)
		//shace el addvisual ded todos los bichos que contienen el creador
		creadorDeEnemigos.dibujarBichos()
		// mueve todos lo bichos
		creadorDeEnemigos.moverATodos()
		game.addVisual(rama)
		game.addVisualIn(tumba1, game.at(2, 3))
		game.addVisualIn(tumba2, game.at(4, 5))
		game.addVisualIn(tumba3, game.at(6, 7))
		
	}
}



