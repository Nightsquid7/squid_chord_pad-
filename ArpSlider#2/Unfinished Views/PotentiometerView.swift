//
//  PotentiometerView.swift
//  nsquidAudioKit_
//
//  Created by Steven Berkowitz on R 1/12/02.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI

struct Potentiometer: View {

    @State var angle = Angle(degrees: -67)

     init(value: Binding<Double>) {
            self._value = value
     }

        @Binding var value: Double

        let minimumValue: Double = 0
        let maximumValue:Double = 1
        let minimumDegrees: Double = -67
        let maximumDegrees: Double = 250
        let touchSensitivity:Double = 8

        func setAngleDegrees(from translationHeight:CGFloat) {
            let adjustedTranslationHeight = (-Double(translationHeight)/touchSensitivity)
            let degrees: Double = angle.degrees + adjustedTranslationHeight

            if degrees > minimumDegrees && degrees < maximumDegrees {
                self.angle = Angle(degrees: degrees)
                self.value = degrees/4 //max(minimumValue, min(degrees / 4, maximumValue))
           }
        }

        var body: some View {
            // swiftlint:disable identifier_name
            GeometryReader { g in

                ZStack {

                    Circle()
                    .fill(Color.black)
                    Capsule()
                        .fill(Color.white)
                        .frame(width: g.size.width/2, height: g.size.width/5)
                        .offset(x: -g.size.width/4)
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

struct Potentiometer_Previews: PreviewProvider {
    static var previews: some View {
        Potentiometer(value: .constant(68))
    }
}
