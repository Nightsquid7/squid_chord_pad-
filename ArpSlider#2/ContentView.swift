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

    @State var synth = Synth()

    init() {

        AudioKit.output = synth.outputMixer

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

                    TouchPad(count: 7)
                            .coordinateSpace(name: "mainV")
                }
                            .frame(height: g.size.height/4)

                ADSRView(attack: self.$synth.attack,
                         decay: self.$synth.decay,
                         sustain: self.$synth.sustain,
                         release: self.$synth.release,
                         synth: self.$synth)
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
