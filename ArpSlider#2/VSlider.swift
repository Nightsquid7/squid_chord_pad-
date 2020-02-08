//
//  VSlider.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/08.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI

struct VSlider: View {

    @State var yOffset: CGFloat = 100
    @Binding var value: Double
    let min: CGFloat , max: CGFloat
    let width: CGFloat,height: CGFloat

    func setYOffset() -> CGFloat {
        return CGFloat(value)
    }

    var body: some View {

        ZStack {
            Rectangle()
                .stroke(Color.black, lineWidth: 14)
                .cornerRadius(7)
                .frame(width: width, height: height)
             Rectangle()
                .fill(Color.black)
                .cornerRadius(7)
                .frame(width: width, height: height/4)
                .offset(y: yOffset)
                .gesture (
                    DragGesture()
                        .onChanged { value in
                            let newValue = value.translation.height
                            print("newValue: \(newValue)")
                            if newValue > self.min && newValue < self.max {
                                self.value = Double(newValue)
                                print("self.value: \(self.value)")
                                self.yOffset = newValue
                            }
                    }
//                    .onEnded { value in
//
//                    }

                )
        }
    }
}

struct VSlider_Previews: PreviewProvider {
    static var previews: some View {
        VSlider(value: .constant(0), min: 0,max: 1, width: 100, height: 300)
    }
}
