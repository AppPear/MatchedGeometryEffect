import SwiftUI

struct LazyStackView: View {
    @Namespace private var namespace
    @State var selected: Int? = nil

    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10){ item in
                        if selected != item {
                            CellView(namespace: namespace, selected: $selected, id: item)
                        } else {
                            Color.clear
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }

            if let id = selected {
                DetailView(namespace: namespace, selected: $selected, id: id)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LazyStackView()
    }
}
