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
    
    @State var showGeneralInfo = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {Text(zoneParam.parameter.name)
                    .font(.headline)
                // Info button to general info view
                Image(systemName: "info.circle.fill")
                    .onTapGesture {
                        showGeneralInfo = true
                    }
                    .foregroundColor(.customBlue)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Detected Value: \(String(format: "%.2f", zoneParam.value))")
                    if let unit = zoneParam.parameter.unitOfMeasurement {
                        Text(unit)
                    }
                }
                
                if let min = zoneParam.parameter.minSuggestedValue, let max = zoneParam.parameter.maxSuggestedValue {
                    Text("Suggested Values: \(String(format: "%.2f", min)) to \(String(format: "%.2f", max))")
                }
            }
            .font(.subheadline)
            .foregroundColor(.black)
        }
    }
}
