//
//  Model.swift
//  DoorsOpenOttawa
//
//  Created by Giselle Mingue Rios on 2023-11-30.
//

import Foundation

struct Building: Decodable, Identifiable  {
    let id: Int
    let name: String
    let isNew: Bool
    let address: String
    let description: String
    let website: String
    let categoryId: Int
    let category: String
    let saturdayStart: String
    let saturdayClose: String
    let sundayStart: String
    let sundayClose: String
    let isShuttle: Bool
    let isPublicWashrooms: Bool
    let isAccessible: Bool
    let isFreeParking: Bool
    let isBikeParking: Bool
    let isPaidParking: Bool
    let isGuidedTour: Bool
    let isFamilyFriendly: Bool
    let image: String
    let isOCTranspoNearby: Bool
    let imageDescription: String
    let latitude: Double
    let longitude: Double
    let isOpenSaturday: Bool
    let isOpenSunday: Bool
    
    var imag: String {
        return String(image.dropLast(4))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "buildingId"
        case name, isNew, address, description, website, categoryId, category, saturdayStart, saturdayClose, sundayStart, sundayClose, isShuttle, isPublicWashrooms, isAccessible, isFreeParking, isBikeParking, isPaidParking, isGuidedTour, isFamilyFriendly, image, isOCTranspoNearby, imageDescription, latitude, longitude, isOpenSaturday, isOpenSunday
    }
}

struct BuildingContainer: Decodable {
    let language: String
    let version: Int
    let year: Int
    let buildings: [Building]
    

}

func parseBuildingData() -> ([Building], [Building]) {
    guard let url = Bundle.main.url(forResource: "buildings.dataset/buildings", withExtension: "json", subdirectory: "Assets") else {
        print("Missing file: buildings.json")
        return ([], [])
    }

    do {
        let jsonData = try Data(contentsOf: url)
        let buildingDataWrappers = try JSONDecoder().decode([BuildingContainer].self, from: jsonData)
        
        let englishBuildings = buildingDataWrappers
            .filter { $0.language == "en" }
            .flatMap { $0.buildings }
        
        let frenchBuildings = buildingDataWrappers
            .filter { $0.language == "fr" }
            .flatMap { $0.buildings }
        
        return (englishBuildings, frenchBuildings)
    } catch {
        print("Error parsing JSON: \(error)")
        return ([], [])
    }
}
