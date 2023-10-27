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
      CardView(card)
        .padding(4)
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
    }
  }

  private var footer: some View {
    Button("Deal 3 More Cards") {
      // intent to put 3 more cards on the table
    }
    .disabled(false) // if no cards left in deck disabled=true
  }
}

#Preview {
  SetGameView(game: ShapesSetGame())
}
