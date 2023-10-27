import SwiftUI

enum Theme {
  case sport, vechicles, food
}

struct EmojiMatchingGameView: View {
  @ObservedObject var game: EmojiMatchingGame
  private let cardAspectRatio: CGFloat = 2/3
  
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
        .onTapGesture {
          game.choose(card)
        }
    }
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
