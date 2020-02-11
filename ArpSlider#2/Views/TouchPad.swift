//
//  TouchPad.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit
import Combine

struct TouchPad: View {

    @State var count: Int = 0
    @State var rects = [CGRect]()
    @State var isLoaded: Bool = false
    @State var currentIndex: Int = -1

    let colors: [Color]  = [.red,.blue,.orange,.pink,.green,.yellow,.purple]

    // initialize self.rects
    func initRects() {
        rects = (0..<count).map { _ in CGRect() }
        if rects.count == count {
            isLoaded = true
        }
    }

    var body: some View {

        return VStack(spacing: 0) {
            if self.isLoaded {
                ForEach(0..<self.count) { index in
                    Rect(rect: self.$rects[index],
                         color: self.colors[index])
                        .scaleEffect(index == self.currentIndex ? 1.2 : 1)
                }
            }

            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        for (index, rect) in self.rects.enumerated() {
                            if rect.contains(value.location) {
                                self.currentIndex = index
                                NotificationCenter.default.post(name: Notification.Name("touchpad note on"), object: index)
                            }
                        }
                }
                .onEnded { _ in
                    NotificationCenter.default.post(name: Notification.Name("all notes off"), object: nil)
                    self.currentIndex = -1
                }
        )
            .onAppear(perform: self.initRects)
    }

}

struct TouchPad_Previews: PreviewProvider {
    static var previews: some View {
        TouchPad(count: 7)
    }
}
