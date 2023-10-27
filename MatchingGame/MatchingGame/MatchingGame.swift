import Foundation

// View
struct MatchingGame<CardContent> where CardContent: Equatable {
  private(set) var cards: [Card]
  private(set) var score = 0
  private var seenCards = [Card.ID]()

  init(numOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
    var cards = [Card]()
    for pairIndex in 0..<max(2, numOfPairs) {
      cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)a"))
      cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)b"))
    }
    self.cards = cards.shuffled()
  }

  private var indexOfFirstAndOnly: Int? {
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

          scoreMatch()
        } else {
          scoreMismatch(for: cards[potentialMatchIndex])
          scoreMismatch(for: cards[chosenCardIndex])
        }
      } else {
        indexOfFirstAndOnly = chosenCardIndex
      }
      cards[chosenCardIndex].isFaceUp = true
    }
  }

  private mutating func scoreMismatch(for card: Card) {
    if seenCards.contains(card.id) {
      score -= 1
    } else {
      seenCards.append(card.id)
    }
  }

  private mutating func scoreMatch() {
    score += 2
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
