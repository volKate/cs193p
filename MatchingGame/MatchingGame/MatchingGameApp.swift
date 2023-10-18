import SwiftUI

@main
struct MatchingGameApp: App {
  @StateObject var game = EmojiMatchingGame()

  var body: some Scene {
    WindowGroup {
      EmojiMatchingGameView(game: game)
    }
  }
}
