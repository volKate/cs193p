import SwiftUI

struct SetGameView: View {
  private let cardAspectRatio: CGFloat = 2/3
  private var gameCards = [
    SetGame.Card(id: "1"),
    SetGame.Card(isSelected: true, id: "2"),
    SetGame.Card(isMatched: true, id: "3"),
    SetGame.Card(isMismatched: true, id: "4")
  ]


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
    AspectVGrid(items: gameCards, aspectRatio: cardAspectRatio) { card in
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
  SetGameView()
}
