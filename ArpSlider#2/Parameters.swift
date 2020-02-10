//
//  Oscillator.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import AudioKit
import Combine

class Parameters: ObservableObject {

    // ADSR
    @Published var attack: Double = 0.0
    @Published var decay: Double = 0.3
    @Published var sustain: Double = 0.1
    @Published var release: Double = 0.1
    // Delay
    @Published var delayTime: Double = 0.4
    @Published var feedback: Double = 0.2
    @Published var dryWetMix: Double = 0.7
    @Published var pingPong: Bool  = true
    // Filter
    @Published var cutoff: Double = 20_000
    @Published var resonance: Double = 0.1
    // Reverb
    @Published var decayTime: Double = 0.5

    // Oscillators
    // 1
    @Published var pitchbend1: Double = 0
    @Published var vibratoRate1: Double = 0
    @Published var vibratoDepth1: Double = 0
    @Published var waveform1 = AKTable(.sine)
    // 2
    @Published var pitchbend2: Double = 0
    @Published var vibratoRate2: Double = 0
    @Published var vibratoDepth2: Double = 0
    @Published var waveform2 = AKTable(.sine)
    // 3
    @Published var pitchbend3: Double = 0
    @Published var vibratoRate3: Double = 0
    @Published var vibratoDepth3: Double = 0
    @Published var waveform3 = AKTable(.sine)

}
