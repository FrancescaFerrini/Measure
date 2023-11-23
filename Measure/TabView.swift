//
//  TabView.swift
//  Measure
//
//  Created by Francesca Ferrini on 15/11/23.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Label("Rule",systemImage: "ruler.fill")
                }
            TabView()
                .tabItem {
                    Label("Level", systemImage: "level.fill")
                }
        }
    }
}

#Preview {
    TabView()
}
