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
                Section {
                    ForEach(sectors.indices, id: \.self) { index in
                        HStack {
                            ColorPicker("", selection: $sectors[index].color)
                                .labelsHidden()
                            TextField("", text: $sectors[index].text)
                            Button {
                                sectors.remove(at: index)
                            } label: {
                                Image(systemName: "minus.circle")
                            }.disabled(sectors.count < 2)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        sectors.append(Sector(text: "", color: .white))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                        DataStore.shared.save(sectors)
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                }
            }
        }
    }
}
