//
//  ContentView.swift
//  DoorsOpenOttawa
//
//  Created by Giselle Mingue Rios on 2023-11-23.
//

import SwiftUI

struct ContentView: View {
    @State private var buildings : [Building] = parseBuildingData()

    var body: some View {
        VStack {
            TabView {
                HomeView(buildings: $buildings)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                Text("Tab 3")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Saved")
                    }
                Text("Tab 4")
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
            }
        }
    }
}



struct HomeView: View {
    @Binding var buildings : [Building]
    
    var body: some View {
        NavigationView {
            List(buildings) { building in
                CardView(building: building)
            }
            .navigationBarTitle("Doors Open Ottawa")
        }
    }
}

struct CardView: View {
    var building: Building
    var body: some View {
        VStack {
            Image("\(building.imag)")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(building.name)
                    .font(.headline)
                Text(building.address)
                    .font(.subheadline)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
}
