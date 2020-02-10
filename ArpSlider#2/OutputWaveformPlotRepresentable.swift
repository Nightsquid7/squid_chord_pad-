//
//  OutputWaveformPlotRepresentable.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 2/02/10.
//  Copyright © Reiwa 2 nightsquid. All rights reserved.
//

import SwiftUI
import AudioKitUI
import AudioKit

struct OutputWaveformPlot: UIViewRepresentable {

    var input: AKNode
    var g: GeometryProxy

    func makeUIView(context: Context) -> AKNodeOutputPlot {
        let v = AKNodeOutputPlot(input, frame: g.frame(in: .global))
        v.plotType = .rolling
        v.shouldFill = true
        v.shouldMirror = true
        v.color = AKColor.blue
        v.setupPlot()
        return v
    }

    func updateUIView(_ uiView: AKNodeOutputPlot, context: UIViewRepresentableContext<OutputWaveformPlot>) {
        print("update ui view")
        uiView.setupPlot()
        print("uiView.isConnected :\(uiView.isConnected)")
        print("uiView.node : \(uiView.node)")

    }

}
