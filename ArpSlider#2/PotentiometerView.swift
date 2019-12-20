//
//  PotentiometerView.swift
//  nsquidAudioKit_
//
//  Created by Steven Berkowitz on R 1/12/02.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI

struct PotentiometerView: View {

    @State var angle = Angle(degrees: -67)

    init(minDegrees: Double, binding: Binding<Double>) {
            self._value = binding
            self.minimumDegrees = minDegrees
            self.angle.degrees = minDegrees
    }
        // want to get value
//         @Binding var value: CGFloat
             @Binding var value: Double
      
        let minimumValue: Double = 0
        let maximumValue:Double = 1
        let minimumDegrees: Double
        let maximumDegrees: Double = 250
        let touchSensitivity:Double = 8

        func setAngleDegrees(from translationHeight:CGFloat) {
            let adjustedTranslationHeight = (-Double(translationHeight) / touchSensitivity)
            let degrees: Double = angle.degrees + adjustedTranslationHeight

            if degrees > minimumDegrees && degrees < maximumDegrees {
                self.angle = Angle(degrees: degrees)
//                print("degrees: \(degrees)")
//                print(((angle.degrees - minimumDegrees) * (maximumValue - minimumValue) / (maximumDegrees - minimumDegrees)) + adjustedTranslationHeight)
                self.value = degrees / 4
           }

        }

        var body: some View {
            GeometryReader { g in

                ZStack {

                    Circle()
                    .fill(Color.black)
                    Capsule()
                        .fill(Color.white)
                        .frame(width: g.size.width / 2, height: 30)
                        .offset(x: -g.size.width / 4)
                        .rotationEffect(self.angle)
                }// ZStack
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.setAngleDegrees(from: value.translation.height)
                        }

                )
            } //GeometryReader {
        }
}

struct PotentiometerView_Previews: PreviewProvider {
    static var previews: some View {
        PotentiometerView(minDegrees: -67, binding: .constant(68))
    }
}
