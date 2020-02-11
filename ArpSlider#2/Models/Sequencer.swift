//
//  Sequencer.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/11.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import AudioKit
import Combine

class Sequencer {

    var seq = AKAppleSequencer()

    var isPlaying: Bool {
        return self.seq.isPlaying
    }

    let midiFileURL = Bundle.main.url(forResource: " Glass Tiger Beaming Lead #2", withExtension: ".mid")!

    init() {
        seq = AKAppleSequencer(fromURL: midiFileURL)
        seq.enableLooping()
        // bpm of "building a track really quick"
        seq.setTempo(138)

        let midiCallbackInstrument = AKMIDICallbackInstrument()
        midiCallbackInstrument.callback = midiCallback
        seq.setGlobalMIDIOutput(midiCallbackInstrument.midiIn)

    }

    // called in the background every time the sequencer triggers a note
    func midiCallback(statusByte: MIDIByte, note: MIDIByte, velocity: MIDIByte) {
        let status = AKMIDIStatus(byte: statusByte)
        switch status?.type {
        case .noteOn:
            NotificationCenter.default.post(name: Notification.Name("note-on"), object: (note, velocity))
        case .noteOff:
            NotificationCenter.default.post(name: Notification.Name("note-off"), object: note)
        default:
            print("default midiCallback")
        }
    }

}
