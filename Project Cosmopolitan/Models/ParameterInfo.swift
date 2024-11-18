//
//  ParameterInfo.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 15/11/24.
//

import Foundation

struct ParameterInfo: Decodable, Identifiable {
    var id: Int
    let isPositive: Bool
    let range: Range<Double>
    let description: String
    let reference: String?
    let tips: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, isPositive, range, description, reference, tips
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        isPositive = try container.decode(Bool.self, forKey: .isPositive)
        let rangeArray = try container.decode([Double?].self, forKey: .range)
        let lowerBound = rangeArray[0] ?? -.greatestFiniteMagnitude
        let upperBound = rangeArray[1] ?? .greatestFiniteMagnitude
        range = lowerBound..<upperBound
        description = try container.decode(String.self, forKey: .description)
        reference = try container.decode(String?.self, forKey: .reference)
        tips = try container.decode([String]?.self, forKey: .tips)
    }
}
