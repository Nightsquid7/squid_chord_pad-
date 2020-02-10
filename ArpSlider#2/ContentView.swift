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

    @State var showingADSR: Bool = false
    @State var showingDelay: Bool = false
    @State var showingFilter: Bool = false
    @State var showingOscParameters: Bool = false


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

                        TempADSRView(synth: self.$synth, isVisible: self.$showingADSR)
                            .frame(width: g.size.width, height: g.size.height/4)

                        DelayView(synth: self.$synth, isVisible: self.$showingDelay)

                        FilterView(synth: self.$synth, isVisible: self.$showingFilter)
                        
                        OscParameterView(synth: self.$synth, isVisible: self.$showingOscParameters)

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
