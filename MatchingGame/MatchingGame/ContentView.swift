import SwiftUI

enum Theme {
  case sport, vechicles, food
}

struct ContentView: View {

  let themes: [Theme: [String]] = [
    .sport:     ["⚽️", "🏈", "🎾", "🏐", "🏓"],
    .vechicles: ["🚗", "🚌", "🚛", "🚜", "🚑"],
    .food:      ["🍍", "🥓", "🍕", "🍌", "🍔"]
  ]
  @State var selectedTheme: Theme = .sport {
    didSet {
      let emojisBytheme = themes[selectedTheme] ?? []
      emojis = (emojisBytheme + emojisBytheme).shuffled()
    }
  }
  @State var emojis = [String]()

  var body: some View {
    VStack {
      Text("Memorize!")
        .font(.largeTitle)
      ScrollView {
        cards
      }
      Spacer()
      themeSelectors
    }
  }

  var cards: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
      ForEach(emojis.indices, id: \.self) { index in
        CardView(content: emojis[index])
          .aspectRatio(2/3, contentMode: .fit)
      }
    }
    .padding()
    .foregroundColor(.orange)
  }

  func themeSelector(for theme: Theme, label: String, symbol: String) -> some View {
    Button {
      selectedTheme = theme
    } label: {
      VStack {
        Image(systemName: symbol)
          .font(.title)
        Text(label)
          .font(.caption)
      }
    }
  }

  var themeSelectors: some View {
    HStack(alignment: .lastTextBaseline, spacing: 30.0) {
      themeSelector(for: .sport, label: "Sports", symbol: "soccerball")
      themeSelector(for: .food, label: "Food", symbol: "carrot")
      themeSelector(for: .vechicles, label: "Vechicles", symbol: "car")
    }
  }
}

struct CardView: View {
  let content: String
  @State var isFaceUp = false

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
