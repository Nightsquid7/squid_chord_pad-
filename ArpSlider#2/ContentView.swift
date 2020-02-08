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
    @State var synth = Synth()

    init() {

        AudioKit.output = synth.delay

        do {
            try AudioKit.start()
        } catch {
            print(error)
        }

    }

    var body: some View {
        // swiftlint:disable identifier_name
        GeometryReader { g in
            VStack {
                HStack {

                    TouchPad(osc: self.synth.osc,
                             notes: self.$notes, count: self.notes.count)
                            .coordinateSpace(name: "mainV")
                }
                            .frame(height: g.size.height/4)

                ADSRView(attack: self.$synth.osc.attackDuration,
                         decay: self.$synth.osc.decayDuration,
                         sustain: self.$synth.osc.sustainLevel,
                         release: self.$synth.osc.releaseDuration)
                        .frame(height: g.size.height/4)
            }
                    .padding(.horizontal,20)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
