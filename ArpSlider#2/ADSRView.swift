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

    var body: some View {
        VStack {

            ADSREnvelopeView(attack: self.$attack,
                             decay: self.$decay,
                             sustain: self.$sustain,
                             release: self.$release)
                 .stroke(Color.black, lineWidth: 7)

            HStack {
                Potentiometer(minDegrees: -67, binding: self.$attack)
                Potentiometer(minDegrees: -67, binding: self.$decay)
                Potentiometer(minDegrees: -67, binding: self.$sustain)
                Potentiometer(minDegrees: -67, binding: self.$release)
            }
        }
    }
}

struct ADSRView_Previews: PreviewProvider {
    static var previews: some View {
        ADSRView(attack: .constant(1), decay: .constant(30), sustain: .constant(70), release: .constant(20))
    }
}
