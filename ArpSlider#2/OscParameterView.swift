//
//  OscParameterView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct OscParameterView: View {

    @Binding var synth: Synth
    

    var body: some View {
        VStack {
           Text("")
        }
    }
}

struct OscParameterView_Previews: PreviewProvider {
    static var previews: some View {
        OscParameterView(synth: .constant(Synth()))
    }
}
