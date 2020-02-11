//
//  ContentView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit
import AudioKitUI

struct ContentView: View {

    @State var synth = Synth()

    @State var showingTouchpad: Bool = true
    @State var showingADSR: Bool = false
    @State var showingDelay: Bool = false
    @State var showingFilter: Bool = false
    @State var showingOscParameters: Bool = false

//    let plot = AKOutputWaveformPlot()

    init() {

        AudioKit.output = synth.filter

        do {
            try AudioKit.start()
        } catch {
            print(error)
        }

    }

    var body: some View {
        // swiftlint:disable identifier_name
        GeometryReader { g in
                VStack {
                    // 
                    HStack {
                        TouchPad(count: 7)
                            .coordinateSpace(name: "mainV")

                        ChordsView(synth: self.$synth)

                    }
                    .frame(width: g.size.width, height: g.size.height/4)

                    // sequencer controls
                    Rectangle()
                        .fill(self.synth.seq.isPlaying ? Color.red : Color.black)
                        .onTapGesture {
                            self.synth.playSequence()
                    }

                    ScrollView {

                        TempADSRView(synth: self.$synth, isVisible: self.$showingADSR)
                            .padding(.trailing, 10)

                        DelayView(synth: self.$synth, isVisible: self.$showingDelay)
                            .padding(.trailing, 10)

                        FilterView(synth: self.$synth, isVisible: self.$showingFilter)
                            .padding(.trailing, 10)
        
                        OscParameterView(synth: self.$synth, isVisible: self.$showingOscParameters)
                            .padding(.trailing, 10)
                    }

            }
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
