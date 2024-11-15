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
    
    var info: ParameterInfo? {
        let parameter = self.parameter
        for item in parameter.info {
            if item.range.contains(value) {
                return item
            }
        }
        return nil
    }
}
