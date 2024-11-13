//
//  Parameter.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

struct Parameter: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var detectedValue: Double
    var benchmarkValue: Double
    var MinSuggestedValue: Double
    var MaxSuggestedValue: Double
    var unitOfMeasure: String
    var showChart: Bool
}
