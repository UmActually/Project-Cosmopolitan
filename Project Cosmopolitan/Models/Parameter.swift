//
//  Parameter.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

struct _Parameter: Identifiable {
    var id: UUID = UUID()
    var name: String
    var detectedValue: Double
    var benchmarkValue: Double
    var MinSuggestedValue: Double
    var MaxSuggestedValue: Double
    var unitOfMeasure: String
    var showChart: Bool
}

struct Parameter: Decodable, Identifiable {
    let id: Int
    let name: String
    let benchmarkValue: Double?
    let minSuggestedValue: Double?
    let maxSuggestedValue: Double?
    let unitOfMeasurement: String?
    let displaysAsChart: Bool
}
