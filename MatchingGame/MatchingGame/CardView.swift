import SwiftUI

struct CardView: View {
  typealias Card = MatchingGame<String>.Card

  let card: Card

  init(_ card: Card) {
    self.card = card
  }

  var body: some View {
    Pie(endAngle: Angle(degrees: 270))
      .opacity(Constants.Pie.opacity)
      .overlay {
        Text(card.content)
          .font(.system(size: Constants.Font.maxSize))
          .minimumScaleFactor(Constants.Font.scaleFactor)
          .aspectRatio(1, contentMode: .fit)
          .padding(Constants.Pie.inset)
      }
      .padding(Constants.inset)
      .cardify(isFaceUp: card.isFaceUp)
      .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
  }

  private struct Constants {
    static let inset = 4.0
    struct Font {
      static let maxSize = 200.0
      static let minSize = 10.0
      static let scaleFactor = minSize / maxSize
    }
    struct Pie {
      static let opacity = 0.4
      static let inset = 4.0
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
