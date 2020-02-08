//
//  ADSRView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/14.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit

struct ADSRView: View {

    @Binding var attack: Double
    @Binding var decay: Double
    @Binding var sustain: Double
    @Binding var release: Double
    @Binding var synth: Synth

    var body: some View {
        VStack(alignment: .leading) {

            Text("ADSR")

            HStack {
//                Potentiometer(value: self.$synth.attack)
                VSlider(value: self.$synth.attack,
                        min: 0.01,
                        max: 100,
                        width: 100,
                        height: 200)
                    .onReceive(self.synth.$attack, perform: { attack in
                        self.synth.setAttack(attack)
                    })

                Potentiometer(value: self.$synth.decay)
                    .onReceive(self.synth.$decay, perform: { decay in
                        self.synth.setDecay(decay)
                    })

                Potentiometer(value: self.$synth.sustain)
                    .onReceive(self.synth.$sustain, perform: { sustain in
                        self.synth.setSustain(sustain)
                    })

                Potentiometer(value: self.$synth.release)
                    .onReceive(self.synth.$release, perform: { release in
                        self.synth.setRelease(release)
                    })
            }
        }
    }
}

struct ADSRView_Previews: PreviewProvider {
    static var previews: some View {
        ADSRView(attack: .constant(1), decay: .constant(30), sustain: .constant(70), release: .constant(20), synth: .constant(Synth()))
    }
}
