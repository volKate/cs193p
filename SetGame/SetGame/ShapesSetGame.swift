import Foundation
import SwiftUI

class ShapesSetGame: ObservableObject {
  @Published private var game = SetGame()

  var cards: [SetGame.Card] {
    return game.cardsPlaying
  }

  var deckIsEmpty: Bool {
    return game.deck.isEmpty
  }

  func getFeatures(for state: SetGame.Card.State) -> Features {
    var color: Color
    switch state.f1 {
      case .first:
        color = .green
      case .second:
        color = .purple
      case .third:
        color = .pink
    }

    var shape: SetShape
    switch state.f2 {
      case .first:
        shape = .diamond
      case .second:
        shape = .squiggle
      case .third:
        shape = .capsule
    }

    var count: Int
    switch state.f3 {
      case .first:
        count = 1
      case .second:
        count = 2
      case .third:
        count = 3
    }

    var shading: SetShading
    switch state.f4 {
      case .first:
        shading = .solid
      case .second:
        shading = .outlined
      case .third:
        shading = .striped
    }

    return (color, shape, count, shading)
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

  typealias Features = (color: Color, shape: SetShape, count: Int, shading: SetShading)

  enum SetShape {
    case diamond, squiggle, capsule
  }

  enum SetShading {
    case solid, outlined, striped
  }

}
