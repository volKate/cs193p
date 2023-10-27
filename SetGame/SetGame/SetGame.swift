import Foundation

struct SetGame {


  struct Card: Identifiable {
    var isSelected = false
    var isMatched = false
    var isMismatched = false

    var id: String
  }
}
