//
//  FilterView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct FilterView: View {

    @EnvironmentObject var parameters: Parameters
    @Binding var synth: Synth
    @State var isVisible: Bool = false

    var body: some View {
        VStack {

            Text("Cutoff Frequency")
            
            Slider(value: $parameters.cutoff, in: 0...20_000)
                .onReceive(parameters.$cutoff, perform: { cutoff in
                    self.synth.filter.cutoffFrequency = cutoff
                })
        }
    }
}

//struct FilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterView()
//    }
//}