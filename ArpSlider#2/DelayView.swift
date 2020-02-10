//
//  DelayView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct DelayView: View {

    @EnvironmentObject var parameters: Parameters
    @Binding var synth: Synth
    @Binding var isVisible: Bool

    var body: some View {
        VStack {

            Toggle(isOn: $isVisible, label: {
                Text("Delay")
            })

            if isVisible {
                VStack(alignment: .leading) {

                    Text("Time")
                    Slider(value: $parameters.delayTime, in: 0...5)
                        .onReceive(parameters.$delayTime, perform: { delayTime in
                            self.synth.delay.time = delayTime
                        })
                    Text("Feedback")
                    Slider(value: $parameters.feedback, in: 0...1)
                        .onReceive(parameters.$feedback, perform: { feedback in
                            self.synth.delay.feedback = feedback
                        })
                    Text("Dry Wet Mix")
                    Slider(value: $parameters.dryWetMix, in: 0...1)
                        .onReceive(parameters.$dryWetMix, perform: { dryWetMix in
                            self.synth.delay.dryWetMix = dryWetMix
                        })
                }
            }
        }
    }
}

struct DelayView_Previews: PreviewProvider {
    static var previews: some View {
        DelayView(synth: .constant(Synth()), isVisible: .constant(true))
    }
}
