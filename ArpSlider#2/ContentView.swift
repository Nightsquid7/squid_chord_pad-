//
//  ContentView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit


struct ContentView: View {
    @State var notes: [MIDINoteNumber] = [60,63,67,72,74]
    @State var osc = AKOscillatorBank()

    init() {
        osc.waveform = AKTable(.sawtooth)
        osc.attackDuration = 0.0
        osc.decayDuration = 0.3
        osc.sustainLevel = 0.1
        osc.releaseDuration = 0.1

        AudioKit.output = osc

        do {
            try AudioKit.start()
        } catch {
            print(error)
        }
        
    }

    var body: some View {
        GeometryReader { g in
            VStack {
                TouchPad(osc: self.osc)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
