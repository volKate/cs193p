import SwiftUI

struct CardView: View {
  typealias Card = MatchingGame<String>.Card

  let card: Card

  init(_ card: Card) {
    self.card = card
  }

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 10.0)

      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2.0)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(1, contentMode: .fit)
      }
      .opacity(card.isFaceUp ? 1 : 0)

      base.fill()
        .opacity(card.isFaceUp ? 0 : 1)
    }
    .opacity(card.isMatched ? 0 : 1)
  }
}

#Preview {
  HStack {
    CardView(CardView.Card(content: "X", isFaceUp: true, id: "test_1"))
    CardView(CardView.Card(content: "X", id: "test_2"))
    CardView(CardView.Card(content: "X", isMatched: true, id: "test_3"))
  }
  .padding()
  .foregroundStyle(.green)
}
