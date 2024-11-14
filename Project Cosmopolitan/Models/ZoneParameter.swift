//
//  ZoneQuality.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 13/11/24.
//

import Foundation

struct ZoneParameter {
    let parameterID: Int
    let value: Double
    let isRange: Bool
    
    enum CodingKeys: String, CodingKey {
        case value
        case isRange
    }
    
    init(from decoder: any Decoder, parameterIndex: Int) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = QualityModel.parameters[parameterIndex]
        value = try container.decode(Double.self, forKey: .value)
        isRange = try container.decode(Bool.self, forKey: .isRange)
    }
}
