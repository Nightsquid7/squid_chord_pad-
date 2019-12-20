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
    @State var notes2: [MIDINoteNumber] = [51,58,63,70,74,75,77].reversed()
    @State var notes3: [MIDINoteNumber] = [44,51,55,56,60,63,68].reversed()
    @State var notes4: [MIDINoteNumber] = [41,53,55,56,63,67,67].reversed()

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
            VStack {
            HStack {


                TouchPad(osc: self.osc,
                         notes: self.$notes, count: self.notes.count)
                    .coordinateSpace(name: "mainV")
                TouchPad(osc: self.osc,
                         notes: self.$notes2, count: self.notes2.count)
                .coordinateSpace(name: "mainV")

                TouchPad(osc: self.osc,
                        notes: self.$notes3, count: self.notes3.count)
                .coordinateSpace(name: "mainV")

                TouchPad(osc: self.osc,
                         notes: self.$notes4, count: self.notes4.count)
                .coordinateSpace(name: "mainV")


            }
                .frame(height: g.size.height / 2)
                .padding(.horizontal,20)

                ADSRView(attack: self.$osc.attackDuration,
                         decay: self.$osc.decayDuration,
                         sustain: self.$osc.sustainLevel,
                         release: self.$osc.releaseDuration)
                .frame(height: g.size.height / 2)
                .padding(.horizontal,20)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
