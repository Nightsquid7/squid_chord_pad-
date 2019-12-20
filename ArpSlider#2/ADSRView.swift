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
            HStack {
                PotentiometerView(minDegrees: -67, binding: self.$attack)
                PotentiometerView(minDegrees: -67, binding: self.$decay)
                PotentiometerView(minDegrees: -67, binding: self.$sustain)
                PotentiometerView(minDegrees: -67, binding: self.$release)
            }
        }
    }
}

struct ADSRView_Previews: PreviewProvider {
    static var previews: some View {
        ADSRView(attack: .constant(-68), decay: .constant(214),sustain: .constant(124), release: .constant(491))
    }
}
