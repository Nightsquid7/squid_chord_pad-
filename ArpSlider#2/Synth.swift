//
//  Synth.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/08.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import AudioKit
import Combine

class Synth: ObservableObject {

    @Published var attack: Double = 0.0
    @Published var decay: Double = 0.3
    @Published var sustain: Double = 0.1
    @Published var release: Double = 0.1

    var osc1 = AKOscillatorBank()
    var osc2 = AKOscillatorBank()
    var osc3 = AKOscillatorBank()

    var delay = AKStereoDelay()
    var oscillators = [AKOscillatorBank]()

    var oscMixer = AKMixer()
    var outputMixer = AKMixer()

    var notes: [MIDINoteNumber] = [48,55,60,63,67,72,74].reversed()
    var lastPlayedNote: MIDINoteNumber = 0

    var disposables = Set<AnyCancellable>()

    init() {
        self.oscillators.append(osc1)
        self.oscillators.append(osc2)
        self.oscillators.append(osc3)

        osc1.waveform = AKTable(.sawtooth)

        osc2.pitchBend = 12
        osc2.waveform = AKTable(.square)

        osc3.pitchBend = -12
        osc3.waveform = AKTable(.reverseSawtooth)

        setAttack(0.0)
        setDecay(0.3)
        setSustain(0.1)
        setRelease(0.1)

        oscMixer = AKMixer(osc1, osc2, osc3)
        delay = AKStereoDelay(oscMixer, maximumDelayTime: 5.0, time: 0.4, feedback: 0.2, dryWetMix: 0.7, pingPong: true)
        outputMixer = AKMixer(delay, oscMixer)
        setListeners()
    }

    func setAttack(_ newValue: Double) {
        oscillators.forEach { osc in
            osc.attackDuration = newValue
        }
    }
    func setDecay(_ newValue: Double) {
        oscillators.forEach { osc in
            osc.decayDuration = newValue
        }
    }
    func setSustain(_ newValue: Double) {
        oscillators.forEach { osc in
            osc.sustainLevel = newValue
        }
    }
    func setRelease(_ newValue: Double) {
        oscillators.forEach { osc in
            osc.releaseDuration = newValue
        }
    }

    // play a note received from the touchpad
    // the touchpads functionality is  -
    //   you can only play one note at a time (monophonic),
    //   AND you cannot play the same note multiple times in succession...
    //    * will stop last previously played note
    func playNote(at index: Int) {
        let noteToPlay = notes[index]
        // only play a new note if it is different from the last note
        if lastPlayedNote != noteToPlay {
            self.oscillators.forEach { osc in
                osc.stop(noteNumber: lastPlayedNote)
                osc.play(noteNumber: noteToPlay, velocity: 77)
            }
            lastPlayedNote = noteToPlay
        }
    }

    // respond to notifications that are generated on the touchpad
    func setListeners() {
        // set note on listener
        _ = NotificationCenter.default.publisher(for: Notification.Name("note on"))
            .sink(receiveValue: { notification in
                if let index = notification.object as? Int {
                    self.playNote(at: index)
                }
            })
            .store(in: &disposables)

        // set note off listener
        _ = NotificationCenter.default.publisher(for: Notification.Name("all notes off"))
            .sink(receiveValue: { _ in
                // stop all notes
                self.oscillators.forEach { osc in
                   (0...120).forEach {
                       osc.stop(noteNumber: $0)
                   }
                }
                self.lastPlayedNote = 0
            })
            .store(in: &disposables)
    }

}
