//
//  MapView.swift
//  DoorsOpenOttawa
//
//  Created by Giselle Mingue Rios on 2023-12-01.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var buildings : [Building] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6972),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var selectedBuilding: Building?
    @State private var showingModal = false

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: buildings) { building in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)) {
                    Button(action: {
                        selectedBuilding = building
                        showingModal = true
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            if showingModal, let building = selectedBuilding {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showingModal = false
                    }
                VStack {
                    Text(building.name)
                    Button("Dismiss") {
                        showingModal = false
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            }
        }
        .onAppear {
            let (englishBuildings, _) = parseBuildingData()
            buildings = englishBuildings
        }
    }
}

#Preview {
    MapView()
}
