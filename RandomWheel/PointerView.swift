//
//  PointerView.swift
//  RandomWheel
//
//  Created by 木門 on 2025/4/20.
//
import SwiftUI

struct PointerView: View {
    let side: Double
    let sqrt3 = 887.0 / 512.0
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: side, y: 0))
            path.addLine(to: CGPoint(x: side / 2.0, y: side / 2 * sqrt3))
            path.closeSubpath()
        }.fill(.white).stroke(.black, lineWidth: 2).frame(width: side, height: side / 2 * sqrt3)
    }
}

#Preview {
    ZStack(alignment: Alignment.center) {
        PointerView(side: 30.0)
    }
}
