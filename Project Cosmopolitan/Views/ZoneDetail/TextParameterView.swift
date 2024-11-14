//
//  MicrobiologicalParametersView.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

struct MicrobiologicalParametersView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(ParameterViewModel().parameters) { parameter in
                    if parameter.MaxSuggestedValue == 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(parameter.name)
                                .font(.headline)
                                .foregroundColor(Color.blue)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Detected Value: \(String(format: "%.2f", parameter.detectedValue))")
                                    Text(parameter.unitOfMeasure)
                                }
                                Text("Suggested Values: \(String(format: "%.2f", parameter.MinSuggestedValue)) to \(String(format: "%.2f", parameter.MaxSuggestedValue))")
                            }
                            .font(.subheadline)
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct TextParameterView: View {
    let parameter: ZoneParameter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(parameter.type.name)
                .font(.headline)
                .foregroundColor(Color.blue)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Detected Value: \(String(format: "%.2f", parameter.value))")
                    if let unit = parameter.type.unitOfMeasurement {
                        Text(unit)
                    }
                }
                
                if let min = parameter.type.minSuggestedValue, let max = parameter.type.maxSuggestedValue {
                    Text("Suggested Values: \(String(format: "%.2f", min)) to \(String(format: "%.2f", max))")
                }
            }
            .font(.subheadline)
            .foregroundColor(.black)
        }
    }
}
