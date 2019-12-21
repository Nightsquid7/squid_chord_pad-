//
//  ADSRFrame.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/21.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI

struct ADSRFrame: Shape {


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
        var attackXOffset: CGFloat = attackXConstant - CGFloat(attack * 100)
        var sustainYLevel: CGFloat = minY + CGFloat(sustain)
        var decayYOffset: CGFloat = attackXConstant + CGFloat(decay)
        var releaseXOffset: CGFloat = sustainXConstant - CGFloat(release)
        // CGPoints
        let attackStart = CGPoint(x: attackXConstant - CGFloat(attack * 100), y: minY)
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

struct ADSRFrame_Previews: PreviewProvider {
    static var previews: some View {
        ADSRFrame(attack: .constant(1), decay: .constant(40), sustain: .constant(-10), release: .constant(-30))
    }
}
