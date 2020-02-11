//
//  ChordsView.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct ChordsView: View {

    @Binding var synth: Synth
    @State var currentChord: Int = 0

    var body: some View {
        HStack {
            ForEach(0...2, id: \.self) { column in
                VStack {
                    ForEach(0...2, id: \.self) { row in
                        Rectangle()
                            .fill((column + (row * 3) == self.currentChord) ? Color.red : Color.black)
                            .onTapGesture {
                                self.currentChord = column + (row * 3)
                                self.synth.currentChordIndex = self.currentChord
                        }
                    }
                }
            }
        }
    }
}

//struct ChordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChordsView()
//    }
//}
