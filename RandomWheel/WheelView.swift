//
//  WheelView.swift
//  RandomTool
//
//  Created by 木門 on 2025/4/20.
//

import SwiftUI

struct WheelView: View {
    let sectors: [Sector]
    @State var rotation: Double = 0
    @State var isSpinning: Bool = false
    @State var selectedSector: Sector? = nil

    var anglePerSector: Double {
        guard sectors.count > 0 else { return 360.0 }
        return 360.0 / Double(sectors.count)
    }

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(
                x: geometry.size.width / 2.0,
                y: geometry.size.height / 2.0
            )
            let radius = min(geometry.size.width, geometry.size.height) / 2.1

            ZStack {
                Circle().fill(.gray).frame(
                    width: radius * 2.1,
                    height: radius * 2.1
                )
                ForEach(0..<sectors.count, id: \.self) { index in
                    SectorView(
                        anglePerSector: anglePerSector,
                        center: center,
                        radius: radius,
                        index: index,
                        sector: sectors[index]
                    )
                }
            }.rotationEffect(Angle(degrees: rotation)).overlay(
                ZStack {
                    PointerView(side: radius / 4)
                    Text(selectedSector?.text ?? "").offset(
                        CGSize(width: 0, height: -radius / 2)
                    ).font(.title2).fontWeight(.medium).animation(
                        .none,
                        value: selectedSector?.text ?? ""
                    )
                }.offset(
                    CGSize(width: 0, height: -radius)
                )

            ).overlay(
                Button {
                    spin()
                } label: {
                    ZStack {
                        Circle().fill(.white).frame(width: 100, height: 100)
                        Text("Spin")
                    }
                }
                .disabled(isSpinning)
            )
        }
    }

    func spin() {
        guard !isSpinning else { return }

        isSpinning = true
        selectedSector = nil

        let winningIndex = Int.random(in: 0..<sectors.count)
        let targetMiddleAngle =
            anglePerSector * Double(sectors.count - winningIndex)
            - anglePerSector / 2.0
        let randomCompleteRotations = Double(Int.random(in: 5...8) * 360)
        let randomTargetAngle =
            targetMiddleAngle
            + Double.random(
                in: (-anglePerSector / 2.1)...(anglePerSector / 2.1)
            )
        let finalTargetRotation = randomTargetAngle + randomCompleteRotations

        let animationDuration = 3.0
        withAnimation(.easeOut(duration: animationDuration)) {
            rotation = finalTargetRotation
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            selectedSector = sectors[winningIndex]
            rotation = rotation.truncatingRemainder(
                dividingBy: 360
            )
            isSpinning = false
        }
    }
}

struct SectorView: View {
    let anglePerSector: Double
    let center: CGPoint
    let radius: Double
    let index: Int
    let sector: Sector

    var body: some View {
        let startAngle = Angle(
            degrees: anglePerSector * Double(index) - 90
        )
        let endAngle = Angle(
            degrees: anglePerSector * Double(index + 1) - 90
        )
        let color = sector.color

        Path { path in
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
            path.closeSubpath()
        }.fill(color)

        let midAngleDegress =
            anglePerSector * Double(index) + anglePerSector / 2.0
            - 90
        let midAngleRadians = Angle(degrees: midAngleDegress)
            .radians

        let textRadius = radius * 0.7
        let textX =
            center.x + CGFloat(cos(midAngleRadians))
            * textRadius
        let textY =
            center.y + CGFloat(sin(midAngleRadians))
            * textRadius

        Text(sector.text).font(.title).fontWeight(
            .semibold
        ).foregroundColor(.white).rotationEffect(
            Angle(degrees: midAngleDegress + 90)
        )
        .position(CGPoint(x: textX, y: textY))
    }
}

#Preview {
    WheelView(sectors: [
        Sector(text: "1", color: .red), Sector(text: "2", color: .green),
    ])
}
