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
    let benchmarkValue: Double?
    let minSuggestedValue: Double?
    let maxSuggestedValue: Double?
    let unitOfMeasurement: String?
    let displaysAsChart: Bool
    let info: [ParameterInfo]
    
    static let parameters: [Self] = decodeJSON(from: "Parameters")
}
