import SwiftUI

struct CellView: View {
    let namespace: Namespace.ID
    @Binding var selected: Int?
    var id: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .matchedGeometryEffect(id: id, in: namespace)
            Text(String(id))
                .font(.title)
                .foregroundColor(.white)
                .matchedGeometryEffect(id: String("\(id)label"), in: namespace)
        }

        .frame(width: 100, height: 100)
        .onTapGesture {
            withAnimation(.easeInOut) {
                selected = id
            }
        }
    }
}


struct CellView_Previews: PreviewProvider {
    @Namespace private static var namespace
    @State static var selected: Int? = 1
    static var previews: some View {
        CellView(namespace: namespace, selected: $selected, id: 1)
    }
}
