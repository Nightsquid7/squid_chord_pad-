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
    @State var notes: [MIDINoteNumber] = [48,55,60,63,67,72,74].reversed()
    @State var osc = AKOscillatorBank()
    var mixer = AKMixer()
    var delay = AKStereoDelay()
    init() {

        osc.waveform = AKTable(.sawtooth)
        osc.attackDuration = 0.0
        osc.decayDuration = 0.3
        osc.sustainLevel = 0.1
        osc.releaseDuration = 0.1

        delay = AKStereoDelay(osc, maximumDelayTime: 5.0, time: 0.4, feedback: 0.2, dryWetMix: 0.7, pingPong: true)


        AudioKit.output = delay

        do {
            try AudioKit.start()
        } catch {
            print(error)
        }
        
    }

    var body: some View {
        GeometryReader { g in

            HStack {

                TouchPad(osc: self.osc,
                         notes: self.$notes, count: self.notes.count)

                VStack {
                Rectangle()
                    .onTapGesture {
                        self.notes = [49,56,61,64,68,73,75].reversed()
                }

                Rectangle()
                    .onTapGesture {
                        self.notes = [48,55,60,63,67,72,74].reversed()
                }
                }
                VStack {
                Rectangle()
                    .onTapGesture {
                        self.notes = [44,51,55,56,60,63,68].reversed()
                }

                Rectangle()
                    .onTapGesture {
                        self.notes = [41,53,55,56,63,67,68].reversed()
                }
                }
            }
            .frame(height: g.size.height / 2)
            .padding(.horizontal,20)
                .coordinateSpace(name: "mainV")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
