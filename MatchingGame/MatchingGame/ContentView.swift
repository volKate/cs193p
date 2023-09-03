import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack {
      CardView()
      CardView(isFaceUp: false)
    }
    .padding()
    .foregroundColor(.orange)
  }
}

struct CardView: View {
  var isFaceUp = true

  var body: some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: 10.0)
          .foregroundColor(.white)
        RoundedRectangle(cornerRadius: 10.0)
          .strokeBorder(.orange, lineWidth: 2.0)
        Text("🐣")
      } else {
        RoundedRectangle(cornerRadius: 10.0)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
