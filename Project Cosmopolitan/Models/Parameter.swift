//
//  Parameter.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

struct Parameter: Decodable, Identifiable {
    let id: Int
    let name: String
    let lowerBound: Double?
    let upperBound: Double?
    let domain: ClosedRange<Double>
    let unitOfMeasurement: String?
    let displaysAsChart: Bool
    var info: [ParameterInfo]
    
    enum CodingKeys: String, CodingKey {
        case id, name, idealRange, domainRange, unitOfMeasurement, displaysAsChart, info
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let idealRange = try container.decode([Double?].self, forKey: .idealRange)
        lowerBound = idealRange[0]
        upperBound = idealRange[1]
        let domainRange = try container.decode([Double].self, forKey: .domainRange)
        domain = domainRange[0]...domainRange[1]
        unitOfMeasurement = try container.decode(String?.self, forKey: .unitOfMeasurement)
        displaysAsChart = try container.decode(Bool.self, forKey: .displaysAsChart)
        info = try container.decode([ParameterInfo].self, forKey: .info)
        for index in 0..<info.count {
            info[index].id = id * 10 + info[index].id
        }
    }
    
    static let parameters: [Self] = decodeJSON(from: "Parameters")
}
