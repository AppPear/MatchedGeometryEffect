import SwiftUI

struct DetailView: View {
    let namespace: Namespace.ID
    @Binding var selected: Int?
    var id: Int
    @State private var offset = CGSize.zero

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 36.0)
                    .foregroundColor(.white)
                    .shadow(radius: 12.0)
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .matchedGeometryEffect(id: id, in: namespace)
                            .frame(maxHeight: 100)
                        Text(String(id))
                            .font(.title)
                            .foregroundColor(.white)
                            .matchedGeometryEffect(id: String("\(id)label"), in: namespace)
                    }

                    HStack {
                        VStack(alignment: .leading){
                            Text("Title")
                                .font(.title)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                .font(.callout)
                                .padding(.top, 2)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: 200)
                .padding()
            }
            .frame(width: 300, height: 300)
            Spacer()
        }
        .offset(offset)
        .onTapGesture {
            withAnimation(.easeInOut) {
                selected = nil
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    withAnimation(Animation.linear(duration: 0.05)) {
                        self.offset = gesture.translation
                    }
                }

                .onEnded { _ in
                    if CGPointDistance(from: .zero, to: CGPoint(x: offset.width, y: offset.height)) > 200 {
                        withAnimation(.interactiveSpring()) {
                            selected = nil
                        }
                    } else {
                        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.66, blendDuration: 0.45)) {
                            self.offset = .zero
                        }
                    }
                }
        )
    }
}

extension DetailView {
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}

struct DetailView_Previews: PreviewProvider {
    @Namespace private static var namespace
    @State static var selected: Int? = 1

    static var previews: some View {
        DetailView(namespace: namespace, selected: $selected, id: 1)
    }
}
