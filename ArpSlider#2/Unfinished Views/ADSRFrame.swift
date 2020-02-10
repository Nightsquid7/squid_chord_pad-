//
//  ADSRFrame.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/21.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI

struct ADSREnvelopeView: Shape {

    @Binding var attack: Double
    @Binding var decay: Double
    @Binding var sustain: Double
    @Binding var release: Double

    func path(in rect: CGRect) -> Path {
        // CGFloats
        // constants
        let maxX = rect.maxX - rect.size.width/8
        let minX = rect.minX + rect.size.width/8
        // SwiftUI Y coordinate increases from top to bottom
        let minY = rect.maxY - rect.size.height/8
        let maxY = rect.minY + rect.size.height/8
        let attackXConstant = minX + rect.size.width/8
        let sustainXConstant = maxX - rect.size.width/8
        // non-constants
        var _: CGFloat = attackXConstant - CGFloat(attack)
        let sustainYLevel: CGFloat = minY + CGFloat(sustain)
        let decayYOffset: CGFloat = attackXConstant + CGFloat(decay)
        let releaseXOffset: CGFloat = sustainXConstant - CGFloat(release)
        // CGPoints
        let attackStart = CGPoint(x: attackXConstant, y: minY)
        let attackStop = CGPoint(x: attackXConstant, y: maxY)
        let decayEnd = CGPoint(x: decayYOffset, y: sustainYLevel)
        let sustainEnd = CGPoint(x: sustainXConstant, y:sustainYLevel)
        let releaseEnd = CGPoint(x: releaseXOffset, y: minY)

        return Path { path in
            path.move(to: attackStart)
            path.addLine(to: attackStop)
            path.addLine(to: decayEnd)
            path.addLine(to: sustainEnd)
            path.addLine(to: releaseEnd)
        }
    }
}

//extension ADSRFrame : VectorArithmetic {
//    static func -= (lhs: inout ADSRFrame, rhs: ADSRFrame) {
//
//    }
//
//    static func - (lhs: ADSRFrame, rhs: ADSRFrame) -> ADSRFrame {
//        var newAttack = lhs.attack - rhs.attack
//        var newDecay = lhs.decay - rhs.decay
//        var newSustain  = lhs.sustain - rhs.sustain
//        var newRelease = lhs.release - rhs.release
//        return ADSRFrame(attack: newAttack, decay: newDecay, sustain: newSustain, release: newRelease)
//    }
//
//
//    static func += (lhs: inout ADSRFrame, rhs: ADSRFrame) {
//
//    }
//
//    static func + (lhs: ADSRFrame, rhs: ADSRFrame) -> ADSRFrame {
//        var newAttack = lhs.attack + rhs.attack
//        var newDecay = lhs.decay + rhs.decay
//        var newSustain  = lhs.sustain + rhs.sustain
//        var newRelease = lhs.release + rhs.release
//        return ADSRFrame(attack: newAttack, decay: newDecay, sustain: newSustain, release: newRelease)
//
//    }
//
//    init(attack:Double, decay: Double, sustain: Double, release: Double) {
//        self.attack = attack
//        self.decay = decay
//        self.sustain = sustain
//        self.release = release
//    }
//    mutating func scale(by rhs: Double) {
//
//    }
//
//    var magnitudeSquared: Double {
//        return 1
//    }
//
//    static var zero: ADSRFrame {
//        return ADSRFrame(attack: 0, decay: 0, sustain: 0, release: 0)
//    }
//
//    static func == (lhs: ADSRFrame, rhs: ADSRFrame) -> Bool {
//        return true
//    }
//
//
//}

struct ADSRFrame_Previews: PreviewProvider {
    static var previews: some View {
        ADSREnvelopeView(attack: .constant(10), decay: .constant(40), sustain: .constant(-20), release: .constant(-30))
    }
}
