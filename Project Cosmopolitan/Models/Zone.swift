//
//  Models.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import Foundation
import MapKit

typealias Coords = CLLocationCoordinate2D

struct Zone: Decodable, Identifiable {
    let id: Int
    let idString: String
    let name: String
    let vertices: [Coords]
    let center: Coords
    let neighborhoodID: Int
    let neighborhood: String
    let quality: [ZoneParameter]
    
    enum CodingKeys: String, CodingKey {
        case id, idString, name, vertices, neighborhoodID, quality
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        idString = try container.decode(String.self, forKey: .idString)
        name = try container.decode(String.self, forKey: .name)
        neighborhoodID = try container.decode(Int.self, forKey: .neighborhoodID)
        quality = try container.decode([ZoneParameter].self, forKey: .quality)
        
        let rawVertices = try container.decode([[Double]].self, forKey: .vertices)
        var vertices = [Coords]()
        for rawVertex in rawVertices {
            vertices.append(.init(latitude: rawVertex[0], longitude: rawVertex[1]))
        }
        self.vertices = vertices
        center = polygonCentroid(vertices: vertices)
        
        neighborhood = Self.neighborhoods[neighborhoodID - 1]
    }
    
    static let neighborhoods: [String] = {
        let url = Bundle.main.url(forResource: "Neighborhoods", withExtension: "json")!
        let decoder = JSONDecoder()
        return try! decoder.decode([String].self, from: Data(contentsOf: url))
    }()
}

func polygonCentroid(vertices: [Coords]) -> Coords {
    var area: Double = 0
    var centroidLatitude: Double = 0
    var centroidLongitude: Double = 0
    let n = vertices.count

    for i in 0..<n {
        let current = vertices[i]
        let next = vertices[(i + 1) % n]
        
        // Calculate the area of the triangle
        let factor = (current.latitude * next.longitude - next.latitude * current.longitude)
        area += factor
        centroidLatitude += (current.latitude + next.latitude) * factor
        centroidLongitude += (current.longitude + next.longitude) * factor
    }

    area /= 2.0
    let scale = 1 / (6 * area)
    
    // Compute the weighted centroid
    centroidLatitude *= scale
    centroidLongitude *= scale

    return Coords(latitude: centroidLatitude, longitude: centroidLongitude)
}
