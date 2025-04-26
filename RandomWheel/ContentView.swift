//
//  ContentView.swift
//  RandomWheel
//
//  Created by 木門 on 2025/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var sectors = DataStore.shared.load() ?? [
        Sector(text: "1", color: .red),
        Sector(text: "2", color: .green),
    ]

    var body: some View {
        NavigationView {
            ZStack {
                WheelView(sectors: sectors)
            }.padding(20).ignoresSafeArea(.container, edges: .top)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showSettings = true
                        }label: {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(sectors: $sectors)
        }
    }
}

#Preview {
    ContentView()
}
