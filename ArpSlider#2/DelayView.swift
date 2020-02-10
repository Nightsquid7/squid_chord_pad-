//
//  DelayView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct DelayView: View {

    @Binding var synth: Synth
    @State var isVisible: Bool = false

    var body: some View {
        VStack {

            Toggle(isOn: $isVisible, label: {
                Text("Delay")
            })

            if isVisible {
                VStack(alignment: .leading) {

                    Text("Time")
                    Slider(value: self.$synth.delayTime, in: 0...5)
                        .onReceive(self.synth.$delayTime, perform: { delayTime in
                            self.synth.delay.time = delayTime
                        })
                    Text("Feedback")
                    Slider(value: self.$synth.feedback, in: 0...1)
                        .onReceive(self.synth.$feedback, perform: { feedback in
                            self.synth.delay.feedback = feedback
                        })
                    Text("Dry Wet Mix")
                    Slider(value: self.$synth.dryWetMix, in: 0...1)
                        .onReceive(self.synth.$dryWetMix, perform: { dryWetMix in
                            self.synth.delay.dryWetMix = dryWetMix
                        })
                }
            }
        }
    }
}

struct DelayView_Previews: PreviewProvider {
    static var previews: some View {
        DelayView(synth: .constant(Synth()))
    }
}
