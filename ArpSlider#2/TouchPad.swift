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
    @State var currentIndex: Int = -1
    @State var xOffset: CGFloat = 0
    var osc: AKOscillatorBank
    let colors: [Color]  = [.red,.blue,.orange,.pink,.green,.yellow,.purple]

    init(osc: AKOscillatorBank, notes:Binding<[MIDINoteNumber]>, count: Int) {
        self.osc = osc
        self._notes = notes
    }

    // only play a new note if it is different from the last note
    func playNote(at index: Int) {
        let noteToPlay = notes[index]
        if lastPlayedNote != noteToPlay {
            osc.stop(noteNumber: lastPlayedNote)
            osc.play(noteNumber: noteToPlay, velocity: 77)
            lastPlayedNote = noteToPlay
        }
    }

    // stop all notes
    func stopAll() {
        (0...120).forEach {
            osc.stop(noteNumber: $0)
        }
        lastPlayedNote = 0
    }
    // color testing
    func color(_ index: Int, noteNumber: MIDINoteNumber)  -> Color {
        let mod = Double(noteNumber % 12) * 0.1
        var colorIndex = Double(index)
        if colorIndex == 0 { colorIndex = 0.9 }
        let red = colorIndex * 0.1
        let green = colorIndex * 0.02 + mod
        let blue = colorIndex - red
        return Color(red: red, green: green, blue: blue)
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
                         color: self.color(index, noteNumber: self.notes[index]))
                        .scaleEffect(index == self.currentIndex ? 1.2 : 1)
                }
            } else {
                Text("problem loading touchPad")
            }

            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged{ value in
                        for (index, rect) in self.rects.enumerated() {
                            if rect.contains(value.location) {
                                print(index)
                                self.playNote(at: index)
                                self.currentIndex = index
                            }
                        }
                }
                .onEnded { value in
                    self.stopAll()
                    self.currentIndex = -1
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
