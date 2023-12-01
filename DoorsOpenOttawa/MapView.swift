//
//  MapView.swift
//  DoorsOpenOttawa
//
//  Created by Giselle Mingue Rios on 2023-12-01.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location = CLLocation()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

struct MapView: View {
    @State private var buildings : [Building] = parseBuildingData()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6972),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var selectedBuilding: Building?
    @State private var showingModal = false
    @StateObject private var locationManager = LocationManager()

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
                    Text("Distance: \(locationManager.location.distance(from: CLLocation(latitude: building.latitude, longitude: building.longitude)) / 1000) km")
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
    }
}

#Preview {
    MapView()
}
