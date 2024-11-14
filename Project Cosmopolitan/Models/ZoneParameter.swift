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
}
