import Foundation

class ShapesSetGame: ObservableObject {
  @Published private var game = SetGame()

  var cards: [SetGame.Card] {
    return game.cardsPlaying
  }

  // MARK: - Intentions

  func restart() {
    game = SetGame()
  }

}
