import wollok.game.*

object musica {
	const property tema1 = game.sound("tema1.mp3")	
	
	method loopear(tema) {
		tema.shouldLoop(true)
		tema.play()
	}
}
