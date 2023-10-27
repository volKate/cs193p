import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
  var items: [Item]
  var aspectRatio: CGFloat
  @ViewBuilder var content: (Item) -> ItemView

  init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }

  var body: some View {
    GeometryReader { geometry in
      let gridItemWidth = gridItemWidthThatFits(count: items.count, size: geometry.size, atAspectRatio: aspectRatio)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth), spacing: 0)], spacing: 0) {
        ForEach(items) { item in
          content(item)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .padding(5)
        }
      }
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
