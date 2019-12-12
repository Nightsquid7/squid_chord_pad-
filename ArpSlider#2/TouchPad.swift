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


    @Binding var notes: [MIDINoteNumber]//  = [48,55,60,63,67,72,74]
    @State var count: Int = 0
    @State var rects = [CGRect]()
    @State var isLoaded: Bool = false
    @State var lastPlayedNote: MIDINoteNumber = 0
    @State var xOffset: CGFloat = 0
    var osc: AKOscillatorBank
    let colors: [Color]  = [.red,.blue,.orange,.pink,.green,.yellow,.purple]

    init(osc: AKOscillatorBank, notes:Binding<[MIDINoteNumber]>, count: Int) {
        self.osc = osc
        self._notes = notes

    }

    func playNote(at index: Int) {
        let noteToPlay = notes[index]
        if lastPlayedNote != noteToPlay {
            osc.stop(noteNumber: lastPlayedNote)
            osc.play(noteNumber: noteToPlay, velocity: 77)
            lastPlayedNote = noteToPlay
        }
    }
    func color(_ index: Int) -> Color {
        if index == 0 {
            return Color(red: Double(100 % 123),
                         green: Double(100 % 234),
                         blue: Double(100 % 789))
        }
        return Color(red: Double(index * index - 123),
                     green: Double(index - index * 4),
                     blue: Double(index + index * 3))
    }

    func stopAll() {
        (0...120).forEach {
            osc.stop(noteNumber: $0)
        }
        lastPlayedNote = 0
    }

    // initialize self.rects
    func initRects() {
        rects = notes.map { _ in CGRect() }
        self.count = notes.count
        if rects.count == count {
            isLoaded = true
        }

    }

    var body: some View {

        return VStack(spacing: 0) {
            if self.isLoaded {
                ForEach(0..<self.notes.count) { index in
                    Rect(rect: self.$rects[index],
                         color: self.colors[index])
                }
            } else {
                Text("loading...")
            }

            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged{ value in
                        for (index, rect) in self.rects.enumerated() {
                            if rect.contains(value.location) {
                                self.playNote(at: index)
                            }
                        }
                }
                .onEnded { value in
                    self.stopAll()
                }
        )
            .onAppear(perform: self.initRects)
    }

}

struct TouchPad_Previews: PreviewProvider {
    static var previews: some View {
        TouchPad(osc: AKOscillatorBank(), notes: .constant([48,55,60,63,67,72,74]), count: 7)
    }
}
