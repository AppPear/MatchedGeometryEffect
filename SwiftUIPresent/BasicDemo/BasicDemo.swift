import SwiftUI

struct BasicDemo: View {
    @Namespace private var namespace
    @State var isClicked = false

    var body: some View {
        VStack {
            if !isClicked {
                Circle()
                    .matchedGeometryEffect(id: "circle", in: namespace)
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            Spacer()
            if isClicked {
                Circle()
                    .matchedGeometryEffect(id: "circle", in: namespace)
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct BasicDemo_Previews: PreviewProvider {
    static var previews: some View {
        BasicDemo()
    }
}
