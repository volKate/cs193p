import SwiftUI

struct ContentView: View {
  let emojis = ["🕷️", "🎃", "👹", "🕸️", "👻", "😈", "💀", "🧙‍♀️", "🍭"]

  var body: some View {
    HStack {
      ForEach(emojis.indices, id: \.self) { index in
        CardView(content: emojis[index])
      }
    }
    .padding()
    .foregroundColor(.orange)
  }
}

struct CardView: View {

  let content: String
  @State var isFaceUp = true

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 10.0)

      Group {
        base.fill(.white)
        base.strokeBorder(.orange, lineWidth: 2.0)
        Text(content)
      }
      .opacity(isFaceUp ? 1 : 0)

      base.fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .onTapGesture {
      isFaceUp.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
