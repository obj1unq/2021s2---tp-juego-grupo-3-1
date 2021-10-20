import wollok.game.*

object musica {
	
	method tema1() {
		const tema1 = game.sound("tema1.mp3")
		tema1.shouldLoop(true)
		return tema1
	}
	
}
