//
//  Sector.swift
//  RandomTool
//
//  Created by 木門 on 2025/4/20.
//

import Foundation
import SwiftUI
import UIKit

extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)

        guard
            let uiColor = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: data
            )
        else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "can't decode UIColor"
            )
        }
        self.init(uiColor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        let uiColor = UIColor(self)
        let data = try NSKeyedArchiver.archivedData(
            withRootObject: uiColor,
            requiringSecureCoding: true
        )

        try container.encode(data)
    }
}

struct Sector: Identifiable, Codable, Equatable {
    let id: UUID
    var text: String
    var color: Color
    init(text: String, color: Color) {
        self.id = UUID()
        self.text = text
        self.color = color
    }
}
