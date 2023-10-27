import SwiftUI

struct CardView: View {
  var card: SetGame.Card

  init(_ card: SetGame.Card) {
    self.card = card
  }

  var body: some View {
    let base = RoundedRectangle(cornerRadius: 10.0)
    ZStack {
      base
        .strokeBorder(lineWidth: 2.0)
        .foregroundColor(card.isMatched ? .green : card.isMismatched ? .red : .gray)
      if card.isSelected {
        base
          .fill(.gray)
          .opacity(0.3)
      }
    }
  }
}