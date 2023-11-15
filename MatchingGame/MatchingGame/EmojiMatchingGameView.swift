import SwiftUI

enum Theme {
  case sport, vechicles, food
}

struct EmojiMatchingGameView: View {
  @ObservedObject var game: EmojiMatchingGame
  private let cardAspectRatio: CGFloat = 2/3
  private let spacing: CGFloat = 4

  var body: some View {
    VStack {
      Text("Memorize!")
        .font(.largeTitle)
      stats
      cards
      Spacer()
      restart
    }
    .padding()
  }

  private var stats: some View {
    HStack {
      Text(game.themeName.capitalized)
        .animation(nil)
      Spacer()
      Text("Score: \(game.score)")
        .animation(nil)
    }
  }

  private var restart: some View {
    Button("New Game") {
      // intention to start new game
      withAnimation {
        game.restart()
      }
    }
  }

  private var cards: some View {
    AspectVGrid(items: game.cards, aspectRatio: cardAspectRatio) { card in
      CardView(card)
        .padding(spacing)
        .onTapGesture {
          withAnimation {
            game.choose(card)
          }
        }
    }
    .foregroundColor(game.themeColor)
  }
}

#Preview {
  EmojiMatchingGameView(game: EmojiMatchingGame())
}
