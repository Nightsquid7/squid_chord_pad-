//
//  Oscillator.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import AudioKit
import Combine

class Oscillator: ObservableObject {

    @Published var pitchbend: Double = 0
    @Published var vibratoRate: Double = 0
    @Published var vibratoDepth: Double = 0
    @Published var waveform = AKTable(.sine)

    let osc = AKOscillatorBank()

}
