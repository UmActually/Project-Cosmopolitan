//
//  MicrobiologicalParametersView.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

struct TextParameterView: View {
    let zoneParam: ZoneParameter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(zoneParam.parameter.name)
                .font(.headline)
                .foregroundColor(Color.blue)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Detected Value: \(String(format: "%.2f", zoneParam.value))")
                    if let unit = zoneParam.parameter.unitOfMeasurement {
                        Text(unit)
                    }
                }
                
                if let lower = zoneParam.parameter.lowerBound, let upper = zoneParam.parameter.upperBound {
                    Text("Suggested Values: \(String(format: "%.2f", lower)) to \(String(format: "%.2f", upper))")
                }
            }
            .font(.subheadline)
            .foregroundColor(.black)
        }
    }
}
