import SwiftUI

struct CardView: View {
  typealias Card = MatchingGame<String>.Card

  let card: Card

  init(_ card: Card) {
    self.card = card
  }

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)

      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: Constants.lineWidth)
        Text(card.content)
          .font(.system(size: Constants.Font.maxSize))
          .minimumScaleFactor(Constants.Font.scaleFactor)
          .aspectRatio(1, contentMode: .fit)
      }
      .opacity(card.isFaceUp ? 1 : 0)

      base.fill()
        .opacity(card.isFaceUp ? 0 : 1)
    }
    .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
  }

  private struct Constants {
    static let cornerRadius = 10.0
    static let lineWidth = 2.0
    struct Font {
      static let maxSize = 200.0
      static let minSize = 10.0
      static let scaleFactor = minSize / maxSize
    }
  }
}

#Preview {
  VStack {
    HStack {
      CardView(CardView.Card(content: "X", isFaceUp: true, id: "test_1"))
      CardView(CardView.Card(content: "X", id: "test_2"))
    }
    HStack {
      CardView(CardView.Card(content: "X", isFaceUp: true, isMatched: true, id: "test_3"))
      CardView(CardView.Card(content: "X", isMatched: true, id: "test_4"))
    }
  }
  .padding()
  .foregroundStyle(.green)
}
