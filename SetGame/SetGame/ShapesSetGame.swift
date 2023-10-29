import Foundation

class ShapesSetGame: ObservableObject {
  @Published private var game = SetGame()

  var cards: [SetGame.Card] {
    return game.cardsPlaying
  }

  var deckIsEmpty: Bool {
    return game.deck.isEmpty
  }

  // MARK: - Intentions

  func select(_ card: SetGame.Card) {
    game.select(card)
  }

  func dealMoreCards() {
    game.dealMoreCards()
  }

  func restart() {
    game = SetGame()
  }

}
