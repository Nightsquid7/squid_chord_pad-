//
//  Synth.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/08.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import AudioKit
class Synth {

    var osc = AKOscillatorBank()
    var mixer = AKMixer()
    var delay = AKStereoDelay()

    init() {

        osc.waveform = AKTable(.sawtooth)
        osc.attackDuration = 0.0
        osc.decayDuration = 0.3
        osc.sustainLevel = 0.1
        osc.releaseDuration = 0.1

        delay = AKStereoDelay(osc, maximumDelayTime: 5.0, time: 0.4, feedback: 0.2, dryWetMix: 0.7, pingPong: true)

    }

}
