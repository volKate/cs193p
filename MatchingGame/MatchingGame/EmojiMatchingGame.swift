import Foundation
import SwiftUI

// ViewModel
class EmojiMatchingGame: ObservableObject {
  typealias Card = MatchingGame<String>.Card
  private static let notFoundEmoji = "⁉️"

  @Published private var theme: EmojiMatchingGameTheme
  @Published private var game: MatchingGame<String>

  init() {
    let theme = EmojiMatchingGame.themes.randomElement()!
    self.theme = theme
    self.game = EmojiMatchingGame.createGame(with: theme)
  }


  static private func createGame(with theme: EmojiMatchingGameTheme) -> MatchingGame<String> {
    let shuffledEmojis = theme.emojis.shuffled()
    return MatchingGame(numOfPairs: theme.numberOfPairs) { pairIndex in
      if shuffledEmojis.indices.contains(pairIndex) {
        return shuffledEmojis[pairIndex]
      }
      return notFoundEmoji
    }
  }


  // i use var cards = which is setting cards with smth calculated when initialized
  // but i needed computed property var cards: Type {}
  var cards: [Card] {
    return game.cards
  }

  var themeName: String {
    return theme.name
  }

  var themeColor: Color {
    return EmojiMatchingGame.gameColors[theme.color] ?? .gray
  }

  var score: Int {
    return game.score
  }


  // MARK: - Intentions

  func choose(_ card: Card) {
    game.choose(card)
  }

  func restart() {
    if let theme = EmojiMatchingGame.themes.randomElement() {
      self.theme = theme
      self.game = EmojiMatchingGame.createGame(with: theme)
    }
  }

  // MARK: - Static vars

  private static var gameColors: [String: Color] = [
    "orange": .orange,
    "green": .green,
    "purple": .purple,
    "blue": .blue,
    "red": .red,
    "yellow": .yellow
  ]

  private static var themes = [
    EmojiMatchingGameTheme(name: "food", emojis: ["🌯", "🥓", "🍕", "🍩", "🍔", "🍟", "🥪", "🌭", "🥐", "🌮"], numberOfPairs: 9, color: "orange"),
    EmojiMatchingGameTheme(name: "vehicles", emojis: ["🚗", "🚌", "🚛", "🚜", "🚑", "🚕", "🚎", "🚓", "🚒", "🚚"], numberOfPairs: 8, color: "green"),
    EmojiMatchingGameTheme(name: "haloween", emojis: ["🕷️", "👻", "🎃", "💀", "👹", "👽", "🧙‍♀️", "🪱", "🕸️", "🍬"], numberOfPairs: 7, color: "purple"),
    EmojiMatchingGameTheme(name: "sports", emojis: ["⚽️", "🏈", "🎾", "🏐", "🏓", "🏀", "⚾️", "🎱", "🏉", "🥏"], numberOfPairs: 6, color: "blue"),
    EmojiMatchingGameTheme(name: "flags", emojis: ["🇲🇽", "🇳🇴", "🇵🇱", "🇪🇸", "🇬🇧", "🇰🇪", "🇧🇿", "🇸🇪", "🇮🇹", "🇪🇬"], numberOfPairs: 5, color: "red"),
    EmojiMatchingGameTheme(name: "animals", emojis: ["🐢", "🐊", "🐘", "🐪", "🦒", "🦙", "🦘", "🐅", "🦓", "🦍"], numberOfPairs: 4, color: "yellow")
  ]
}
