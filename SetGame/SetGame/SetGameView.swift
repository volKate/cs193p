import SwiftUI

struct SetGameView: View {
  @ObservedObject var game: ShapesSetGame
  private let cardAspectRatio: CGFloat = 2/3

  var body: some View {
    VStack {
      header
      Spacer()
      cards
      footer
    }
    .padding()
  }

  private var cards: some View {
    AspectVGrid(items: game.cards, aspectRatio: cardAspectRatio) { card in
      let features = game.getFeatures(for: card.state)
      CardView(card, with: features)
        .padding(4)
        .onTapGesture {
          game.select(card)
        }
    }
  }

  private var header: some View {
    HStack {
      Text("set!".uppercased())
        .font(.largeTitle)
      Spacer()
      Image(systemName: "arrow.counterclockwise.circle.fill")
        .imageScale(.large)
        .font(.title2)
        .onTapGesture {
          game.restart()
        }
    }
  }

  private var footer: some View {
    Button("Deal 3 More Cards") {
      game.dealMoreCards()
    }
    .disabled(game.deckIsEmpty)
  }
}

#Preview {
  SetGameView(game: ShapesSetGame())
}
