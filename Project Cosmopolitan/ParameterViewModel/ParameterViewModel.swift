//
//  ParameterViewModel.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

@Observable
class ParameterViewModel {
    
    var parameters = [
        Parameter(name: "Hardness", detectedValue: 20, benchmarkValue: 0, MinSuggestedValue: 13, MaxSuggestedValue: 38, unitOfMeasure: "", showChart: false),
        Parameter(name: "Ph", detectedValue: 7.8 , benchmarkValue: 0, MinSuggestedValue: 6.5, MaxSuggestedValue: 8.5, unitOfMeasure: "", showChart: false),
        Parameter(name: "Dry Residue", detectedValue: 251, benchmarkValue: 0, MinSuggestedValue: 100, MaxSuggestedValue: 500, unitOfMeasure: "mg/l", showChart: false),
        Parameter(name: "Nitrate (NO3)", detectedValue: 4, benchmarkValue: 50, MinSuggestedValue: 0, MaxSuggestedValue: 50, unitOfMeasure: "mg/l", showChart: true),
        Parameter(name: "Nitrite (NO2)", detectedValue: 0.13, benchmarkValue: 0.50, MinSuggestedValue: 0, MaxSuggestedValue: 0.50, unitOfMeasure: "mg/l", showChart: true),
        Parameter(name: "Ammonium", detectedValue: 0.03, benchmarkValue: 0.50, MinSuggestedValue: 0, MaxSuggestedValue: 0.50, unitOfMeasure: "mg/l", showChart: true),
        Parameter(name: "Chloride", detectedValue: 9, benchmarkValue: 250, MinSuggestedValue: 0, MaxSuggestedValue: 250, unitOfMeasure: "mg/l", showChart: true),
        Parameter(name: "Conductivity", detectedValue: 358, benchmarkValue: 2500, MinSuggestedValue: 0, MaxSuggestedValue: 2500, unitOfMeasure: "µS/cm", showChart: true),
        Parameter(name: "Coliform Bacteria", detectedValue: 0, benchmarkValue: 0, MinSuggestedValue: 0, MaxSuggestedValue: 0, unitOfMeasure: "u.f.c./100 ml", showChart: false),
        Parameter(name: "Escherichia coli", detectedValue: 0, benchmarkValue: 0, MinSuggestedValue: 0, MaxSuggestedValue: 0, unitOfMeasure: "u.f.c./100 ml", showChart: false)
        
    ]

   
}

