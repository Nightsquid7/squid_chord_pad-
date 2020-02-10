//
//  ContentView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKit

struct ContentView: View {

    @State var synth = Synth()
    @State var currentChord = 0

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
                    HStack {

                        TouchPad(count: 7)
                            .coordinateSpace(name: "mainV")

                        ChordsView(synth: self.$synth)

                    }
                        .frame(height: g.size.height/4)

                    ScrollView {

                        TempADSRView(synth: self.$synth)
                            .frame(width: g.size.width, height: g.size.height/4)

                        DelayView(synth: self.$synth)

                        FilterView(synth: self.$synth)
                        OscParameterView(synth: self.$synth)

                    }
                    .padding(.horizontal,20)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
