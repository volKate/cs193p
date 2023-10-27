import SwiftUI

enum Theme {
  case sport, vechicles, food
}

struct EmojiMatchingGameView: View {
  @ObservedObject var game: EmojiMatchingGame

  var body: some View {
    VStack {
      Text("Memorize!")
        .font(.largeTitle)
      HStack {
        Text(game.themeName.capitalized)
        Spacer()
        Text("Score: \(game.score)")
      }
      .padding()
      ScrollView {
        cards
          .animation(.default, value: game.cards)
      }
      Spacer()
      Button("New Game") {
        // intention to start new game
        game.restart()
      }
    }
  }

  var cards: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
      ForEach(game.cards) { card in
        CardView(card)
          .aspectRatio(2/3, contentMode: .fit)
          .padding(5)
          .onTapGesture {
            game.choose(card)
          }
      }
    }
    .padding()
    .foregroundColor(game.themeColor)
  }
}

struct CardView: View {
  let card: MatchingGame<String>.Card

  init(_ card: MatchingGame<String>.Card) {
    self.card = card
  }

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 10.0)

      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2.0)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(1, contentMode: .fit)
      }
      .opacity(card.isFaceUp ? 1 : 0)

      base.fill()
        .opacity(card.isFaceUp ? 0 : 1)
    }
    .opacity(card.isMatched ? 0 : 1)
  }
}

#Preview {
  EmojiMatchingGameView(game: EmojiMatchingGame())
}
