import SwiftUI

struct Cardify: ViewModifier {
  let isFaceUp: Bool

  func body(content: Content) -> some View {
    let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)

    ZStack {
      base
        .strokeBorder(lineWidth: Constants.lineWidth)
        .background { base.fill(.white) }
        .overlay { content }
        .opacity(isFaceUp ? 1 : 0)

      base.fill()
        .opacity(isFaceUp ? 0 : 1)
    }
  }

  private struct Constants {
    static let cornerRadius = 10.0
    static let lineWidth = 2.0
  }
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    modifier(Cardify(isFaceUp: isFaceUp))
  }
}
