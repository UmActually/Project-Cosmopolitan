//
//  ZoneQuality.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 13/11/24.
//

import Foundation

struct ZoneParameter: Decodable {
    let parameterID: Int
    let value: Double
    let isRange: Bool
    
    var parameter: Parameter {
        Parameter.parameters[parameterID - 1]
    }
    
    var isWithinRange: Bool {
        guard let min = parameter.lowerBound, let max = parameter.upperBound else {
            return true // Default to true if no range is defined
        }
        return value >= min && value < max
    }
    
    var currentValueInfo: [ParameterInfo] {
        return parameter.info.filter { item in
            item.range.contains(value)
        }
    }
}
