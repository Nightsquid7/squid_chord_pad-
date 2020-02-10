//
//  OscParameterView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit

struct OscParameterView: View {

    @EnvironmentObject var parameters: Parameters
    @Binding var synth: Synth
    @Binding var isVisible: Bool

    var body: some View {
        VStack {
            Toggle(isOn: self.$isVisible, label: {
                Text("Oscillators")

            })

            if isVisible {
                VStack(alignment: .leading) {
                    Text("Oscillator 1")
                    Picker(selection: $parameters.waveform1, label: EmptyView(), content: {
                        Text("Square").tag(AKTable(.square))
                        Text("Sine").tag(AKTable(.sine))
                        Text("Sawtooth").tag(AKTable(.sawtooth))
                    }).pickerStyle(SegmentedPickerStyle())
                        .onReceive(parameters.$waveform1, perform: { waveform in
                            self.synth.osc1.waveform = waveform
                        })
                    Text("Oscillator 2")
                    Picker(selection: $parameters.waveform2, label: EmptyView(), content: {
                        Text("Square").tag(AKTable(.square))
                        Text("Sine").tag(AKTable(.sine))
                        Text("Sawtooth").tag(AKTable(.sawtooth))
                    }).pickerStyle(SegmentedPickerStyle())
                        .onReceive(parameters.$waveform2, perform: { waveform in
                            self.synth.osc2.waveform = waveform
                        })

                    Text("Oscillator 2")
                    Picker(selection: $parameters.waveform3, label: EmptyView(), content: {
                        Text("Square").tag(AKTable(.square))
                        Text("Sine").tag(AKTable(.sine))
                        Text("Sawtooth").tag(AKTable(.sawtooth))
                    }).pickerStyle(SegmentedPickerStyle())
                        .onReceive(parameters.$waveform3, perform: { waveform in
                            self.synth.osc3.waveform = waveform
                        })
                }
            }
        }
    }
}

//struct OscParameterView_Previews: PreviewProvider {
//    static var previews: some View {
//        OscParameterView(synth: .constant(Synth()))
//    }
//}
