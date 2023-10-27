import SwiftUI

@main
struct SetGameApp: App {
  @StateObject var game = ShapesSetGame()

  var body: some Scene {
    WindowGroup {
      SetGameView(game: game)
    }
  }
}
