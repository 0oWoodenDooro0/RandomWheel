//
//  SettingsView.swift
//  RandomWheel
//
//  Created by 木門 on 2025/4/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var sectors: [Sector]

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
            }.navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    @Previewable
    @State var sectors : [Sector] = [
        Sector(text: "123", color: .white)
    ]
    SettingsView(sectors: $sectors)
}
