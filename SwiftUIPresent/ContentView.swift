//
//  ContentView.swift
//  SwiftUIPresent
//
//  Created by Samu András on 2022. 01. 08..
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    @State var isClicked = false
    @State var selected: Int? = nil

    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<10){ item in
                        if selected != item {
                            RoundedRectangle(cornerRadius: 25.0)
                                .matchedGeometryEffect(id: item, in: namespace)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        selected = item
                                    }
                                }
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
        ContentView()
    }
}

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
                    RoundedRectangle(cornerRadius: 25.0)
                        .matchedGeometryEffect(id: id, in: namespace)
                        .frame(maxHeight: 100)
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

