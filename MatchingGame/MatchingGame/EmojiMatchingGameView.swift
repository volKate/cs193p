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
    GeometryReader { geometry in
      let gridItemWidth = gridItemWidthThatFits(count: game.cards.count, size: geometry.size, atAspectRatio: cardAspectRatio)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth), spacing: 0)], spacing: 0) {
        ForEach(game.cards) { card in
          CardView(card)
            .aspectRatio(cardAspectRatio, contentMode: .fit)
            .padding(5)
            .onTapGesture {
              game.choose(card)
            }
        }
      }
      .foregroundColor(game.themeColor)
    }
  }

  private func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
    var cols = 1.0
    let count = CGFloat(count)

    repeat {
      let width = size.width / cols
      let height = width / aspectRatio

      let rows = (count / cols).rounded(.up)

      if rows * height < size.height {
        return width.rounded(.down)
      }
      cols += 1
    } while cols < count

    return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
