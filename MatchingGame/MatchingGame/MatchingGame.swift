import Foundation

// View
struct MatchingGame<CardContent> where CardContent: Equatable {
  private(set) var cards: [Card]

  init(numOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
    var cards = [Card]()
    for pairIndex in 0..<max(2, numOfPairs) {
      cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)a"))
      cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)b"))
    }
    self.cards = cards.shuffled()
  }

  var indexOfFirstAndOnly: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set { cards.indices.forEach { cards[$0].isFaceUp = false } }
  }

  mutating func choose(_ card: Card) {
    if let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }) {
      if card.isFaceUp || card.isMatched { return }

      if let potentialMatchIndex = indexOfFirstAndOnly {
        if cards[potentialMatchIndex].content == card.content {
          cards[potentialMatchIndex].isMatched = true
          cards[chosenCardIndex].isMatched = true
        }
      } else {
        indexOfFirstAndOnly = chosenCardIndex
      }
      cards[chosenCardIndex].isFaceUp = true
    }
  }

  mutating func shuffle() {
    cards.shuffle()
  }

  struct Card: Equatable, Identifiable {
    var content: CardContent
    var isFaceUp = false
    var isMatched = false

    var id: String
  }
}

extension Array {
  var only: Element? {
    count == 1 ? first : nil
  }
}
