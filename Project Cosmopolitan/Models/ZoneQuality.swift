//
//  ZoneQuality.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 13/11/24.
//

import Foundation

struct RecordedParameter {
    let type: Parameter
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

struct ZoneQuality: Decodable {
    let hardness: RecordedParameter
    let ph: RecordedParameter
    let dryResidue: RecordedParameter
    let nitrate: RecordedParameter
    let nitrite: RecordedParameter
    let ammonium: RecordedParameter
    let fluoride: RecordedParameter
    let chloride: RecordedParameter
    let conductivity: RecordedParameter
    let coliformBacteria: RecordedParameter
    let eColi: RecordedParameter
    
    init(from decoder: any Decoder) throws {
        hardness = try RecordedParameter(from: decoder, parameterIndex: 0)
        ph = try RecordedParameter(from: decoder, parameterIndex: 1)
        dryResidue = try RecordedParameter(from: decoder, parameterIndex: 2)
        nitrate = try RecordedParameter(from: decoder, parameterIndex: 3)
        nitrite = try RecordedParameter(from: decoder, parameterIndex: 4)
        ammonium = try RecordedParameter(from: decoder, parameterIndex: 5)
        fluoride = try RecordedParameter(from: decoder, parameterIndex: 6)
        chloride = try RecordedParameter(from: decoder, parameterIndex: 7)
        conductivity = try RecordedParameter(from: decoder, parameterIndex: 8)
        coliformBacteria = try RecordedParameter(from: decoder, parameterIndex: 9)
        eColi = try RecordedParameter(from: decoder, parameterIndex: 10)
    }
}
