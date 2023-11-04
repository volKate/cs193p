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
      HStack {
        Text(game.themeName.capitalized)
        Spacer()
        Text("Score: \(game.score)")
      }
      cards
        .animation(.default, value: game.cards)
      
      Spacer()
      Button("New Game") {
        // intention to start new game
        game.restart()
      }
    }
    .padding()
  }
  
  private var cards: some View {
    AspectVGrid(items: game.cards, aspectRatio: cardAspectRatio) { card in
      CardView(card)
        .padding(spacing)
        .onTapGesture {
          game.choose(card)
        }
    }
    .foregroundColor(game.themeColor)
  }
}

#Preview {
  EmojiMatchingGameView(game: EmojiMatchingGame())
}
