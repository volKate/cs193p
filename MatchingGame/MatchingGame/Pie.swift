import SwiftUI
import CoreGraphics

struct Pie: Shape {
  let startAngle = Angle.zero
  let endAngle: Angle
  let clockwise = false

  func path(in rect: CGRect) -> Path {
    var p = Path()
    let startAngle = startAngle - .degrees(90)
    let endAngle = endAngle - .degrees(90)
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let arcStart = CGPoint(
      x: center.x + radius * cos(startAngle.radians),
      y: center.y + radius * sin(startAngle.radians)
    )

    p.move(to: center)
    p.addLine(to: arcStart)
    p.addArc(
      center: center,
      radius: radius,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: clockwise
    )
    p.addLine(to: center)

    return p
  }
}

#Preview {
  Pie(endAngle: .degrees(270))
}
