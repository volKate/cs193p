import SwiftUI

struct CardView: View {
  var card: SetGame.Card
  let features: ShapesSetGame.Features

  init(_ card: SetGame.Card, with features: ShapesSetGame.Features) {
    self.card = card
    self.features = features
  }

  var body: some View {
    let base = RoundedRectangle(cornerRadius: 10.0)

    ZStack {
      base
        .strokeBorder(lineWidth: 2.0)
        .foregroundColor(card.isMatched ? .green : card.isMismatched ? .red : .gray)
      base
        .fill(card.isSelected ? .gray : .white)
        .opacity(0.3)

      VStack {
        ForEach(0..<features.count, id: \.self) { _ in
          shape
            .foregroundColor(features.color)
            .aspectRatio(2, contentMode: .fit)
        }
      }
      .padding()
    }
  }

  @ViewBuilder
  private var shape: some View {
    switch features.shape {
      case .diamond:
        applyShading(to: Circle())
      case .squiggle:
        applyShading(to: Diamond())
      case .capsule:
        applyShading(to: Capsule())
    }
  }

  @ViewBuilder
  func applyShading(to shape: some Shape) -> some View {
    switch features.shading {
      case .outlined:
        shape.stroke(lineWidth: 2)
      case .solid:
        shape.fill()
      case .striped:
        shape.fill().opacity(0.3)
    }
  }
}
