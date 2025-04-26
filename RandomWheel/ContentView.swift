//
//  ContentView.swift
//  RandomWheel
//
//  Created by 木門 on 2025/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var sectors: [Sector] = [
        Sector(text: "1", color: .red),
        Sector(text: "2", color: .blue),
        Sector(text: "3", color: .green),
        Sector(text: "4", color: .pink),
        Sector(text: "5", color: .yellow),
        Sector(text: "6", color: .purple),
    ]
    @State private var showSettings = false
    var body: some View {
        VStack{
            ZStack {
                WheelView(sectors: sectors)
            }.padding(20)
        }.overlay(alignment: .topTrailing){
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape")
                    .font(.title2)
                    .padding()
                    .background(Circle().fill(.white.opacity(0.8)))
                    .foregroundColor(.black)
                    .shadow(radius: 3)
            }
        }.sheet(isPresented: $showSettings){
            SettingsView(sectors: $sectors)
        }
    }
}

#Preview {
    ContentView()
}
