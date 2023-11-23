//
//  TabController.swift
//  Measure
//
//  Created by Francesca Ferrini on 15/11/23.
//

import SwiftUI
struct TabController: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Label("Rule",systemImage: "ruler.fill")
                        
                }
            LevelView()
                .tabItem {
                    Label("Level", systemImage: "level.fill")
  
                }
        }.onAppear(){
            UITabBar.appearance().backgroundColor = .darkGray
        }.accentColor(.white)
        
    }
}

#Preview {
    TabController()
}

