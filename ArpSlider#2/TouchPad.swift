//
//  TouchPad.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit
struct TouchPad: View {

    @State var notes: [MIDINoteNumber] = [48,55,60,63,67,72,74]
    @State var count: Int = 7
    @State var rects = [CGRect]()
    @State var isLoaded: Bool = false

    func initRects() {
        rects = notes.map { _ in CGRect()}
        if rects.count == count {
            isLoaded = true
        }
    }

    var body: some View {
        VStack {
            if self.isLoaded {
                ForEach(0..<self.notes.count) { index in
                    Rect(rect: self.$rects[index])
                }
            } else {
                Text("loading...")
            }

            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        for (index, rect) in self.rects.enumerated() {
                            if rect.contains(value.location) {
                                print(index)
                            }
                        }
                }
        )
            .onAppear(perform: self.initRects)
    }

}

struct TouchPad_Previews: PreviewProvider {
    static var previews: some View {
        TouchPad()
    }
}
