import Foundation

struct SetGame {
  private var deck: [Card]
  private(set) var cardsPlaying: [Card]

  init() {
    deck = []
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

    deck.shuffle()

    cardsPlaying = Array(deck.prefix(12))

  }


  struct Card: Identifiable {
    enum FeatureValue: Int, CaseIterable {
      case one = 0, two, three
    }

    var isSelected = false
    var isMatched = false
    var isMismatched = false

    var state: (count: FeatureValue.RawValue, color: FeatureValue.RawValue, shape: FeatureValue.RawValue, shading: FeatureValue.RawValue)

    var id: String
  }
}
