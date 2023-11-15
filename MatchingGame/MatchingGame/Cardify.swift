import SwiftUI

struct Cardify: ViewModifier, Animatable {
  var angle: Double

  init (isFaceUp: Bool) {
    angle = isFaceUp ? 180 : 0
  }
  var isFaceUp: Bool {
    return angle > 90
  }

  var animatableData: Double {
    get { angle }
    set { angle = newValue }
  }

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
    .rotation3DEffect(
      .degrees(angle),
      axis: (x: 0.0, y: 1.0, z: 0.0)
    )
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
