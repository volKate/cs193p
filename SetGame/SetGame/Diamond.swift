import SwiftUI

struct Diamond: Shape {
  @ViewBuilder
  func path(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    Path { path in
      path.move(to: CGPoint(x: width/2, y: 0))
      path.addLine(to: CGPoint(x: width, y: height/2))
      path.addLine(to: CGPoint(x: width/2, y: height))
      path.addLine(to: CGPoint(x: 0, y: height/2))
      path.addLine(to: CGPoint(x: width/2, y: 0))
    }
  }
}

#Preview {
    Diamond()
}
