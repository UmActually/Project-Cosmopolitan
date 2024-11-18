//
//  Fountain.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 18/11/24.
//

import Foundation
import CoreLocation

struct Fountain: Decodable, Identifiable {
    let id: Int
    let name: String
    let location: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let locationArray = try container.decode([Double].self, forKey: .location)
        location = CLLocationCoordinate2D(latitude: locationArray[0], longitude: locationArray[1])
    }
}
