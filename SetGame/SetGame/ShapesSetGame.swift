import Foundation

class ShapesSetGame: ObservableObject {
  private var game = SetGame()

  var cards: [SetGame.Card] {
    return game.cardsPlaying
  }
}
