import Foundation

struct SetGame {
  private(set) var deck: [Card]
  private(set) var cardsPlaying: [Card]
  private let setVector: Card.State = (0, 0, 0, 0)
  private let cardsStartCount = 12
  private let cardsInSetCount = 3

  init() {
    deck = SetGame.generateDeck()
    deck.shuffle()

    cardsPlaying = Array(deck.prefix(cardsStartCount))
    deck.removeFirst(cardsStartCount)
  }

  private var selectedCards: [Card] {
    get { cardsPlaying.filter { $0.isSelected } }
  }

  private var setIsMismatched: Bool {
    get { cardsPlaying.filter { $0.isMismatched }.count == cardsInSetCount }
  }

  mutating func select(_ card: Card) {
    let selectedCardIndex = cardsPlaying.firstIndex { $0.id == card.id }
    if let selectedCardIndex {

      // allow deselect if < 3 cards currently selected
      if selectedCards.count < cardsInSetCount {
        cardsPlaying[selectedCardIndex].isSelected.toggle()
      } else if !card.isMatched {
        cardsPlaying[selectedCardIndex].isSelected = true

        if setIsMismatched {
          // if set was mismatched:
          // deselect all cards, reset isMismatched for all cards
          cardsPlaying.indices.forEach {
            cardsPlaying[$0].isMismatched = false
            cardsPlaying[$0].isSelected = $0 == selectedCardIndex
          }
        } else {
          // set was matching, replace matched cards with new
          dealMoreCards()
        }
      }

      // if selectedCards.count == 3, checkMatch and reset selectedCards then select new one
      if selectedCards.count == cardsInSetCount {
        let setMatched = checkSet()
        if setMatched {
          cardsPlaying.indices.forEach { cardsPlaying[$0].isMatched = cardsPlaying[$0].isSelected }
        } else {
          cardsPlaying.indices.forEach { cardsPlaying[$0].isMismatched = cardsPlaying[$0].isSelected }
        }
      }
    }
  }

  mutating func dealMoreCards() {
    let matchedCardsIndices = cardsPlaying.indices.filter { cardsPlaying[$0].isMatched }
    let matchedCardsIds = matchedCardsIndices.map { cardsPlaying[$0].id }

    if matchedCardsIndices.count == cardsInSetCount {
      // replace matched cards with new cards from deck OR
      // if deck is empty, remove them from board
      if deck.isEmpty {
        cardsPlaying.removeAll { matchedCardsIds.contains($0.id) }
      } else if deck.count >= matchedCardsIndices.count {
        matchedCardsIndices.forEach {
          cardsPlaying[$0] = deck.first!
          deck.removeFirst()
        }
      }
    } else if !deck.isEmpty {
      cardsPlaying += Array(deck.prefix(cardsInSetCount))
      deck.removeFirst(cardsInSetCount)
    }
  }

  private func checkSet() -> Bool {
    let sumVector: Card.State = selectedCards.reduce(setVector) { sumVector, card in
      return (
        count: (sumVector.count + card.state.count) % 3,
        color: (sumVector.color + card.state.color) % 3,
        shape: (sumVector.shape + card.state.shape) % 3,
        shading: (sumVector.shading + card.state.shading) % 3
      )
    }

    return sumVector == setVector
  }

  static private func generateDeck() -> [Card] {
    var deck = [Card]()
    var id = 0

    for i in Card.FeatureValue.allCases {
      for j in Card.FeatureValue.allCases {
        for k in Card.FeatureValue.allCases {
          for n in Card.FeatureValue.allCases {

            id += 1
            let countFeatureValue = i.rawValue
            let colorFeatureValue = (i.rawValue + j.rawValue) % 3
            let shapeFeatureValue = (i.rawValue + j.rawValue + k.rawValue) % 3
            let shadingfeatureValue = (i.rawValue + j.rawValue + k.rawValue + n.rawValue) % 3

            deck.append(
              Card(
                state: (
                  countFeatureValue,
                  colorFeatureValue,
                  shapeFeatureValue,
                  shadingfeatureValue
                ),
                id: String(id)
              )
            )

          }
        }
      }
    }

    return deck
  }


  struct Card: Identifiable {
    enum FeatureValue: Int, CaseIterable {
      case one = 0, two, three
    }

    typealias State = (
      count: FeatureValue.RawValue,
      color: FeatureValue.RawValue,
      shape: FeatureValue.RawValue,
      shading: FeatureValue.RawValue
    )

    var isSelected = false
    var isMatched = false
    var isMismatched = false

    var state: State

    var id: String
  }
}
