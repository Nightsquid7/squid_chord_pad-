//
//  Rect.swift
//  ArpSlider#2
//
//  Created by Steven Berkowitz on R 1/12/12.
//  Copyright © Reiwa 1 nightsquid. All rights reserved.
//

import SwiftUI

struct Rect: View {

    @Binding var rect: CGRect

    func getRect(_ geometry: GeometryProxy)  -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
    }

        return Rectangle()
                .fill(Color.black)
                .frame(width: geometry.size.width - 20,
                       height: geometry.size.height / 4 - 5)
                .cornerRadius(8)
                .shadow(radius: 8)
    }
    var body: some View {
        GeometryReader { g in

            self.getRect(g)

        } // geometry R
    }
}

struct TouchView_Previews: PreviewProvider {
    static var previews: some View {
        Rect(rect: .constant(CGRect(x: 1, y: 1, width: 1, height: 1)))
    }
}
