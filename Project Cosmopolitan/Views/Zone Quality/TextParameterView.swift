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
    
    @EnvironmentObject var modelData: ModelData
    @State private var animatedValue: Double = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                // Header with parameter name and detected value
                Text(zoneParam.parameter.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                // Info button to general info view
                Image(systemName: "info.circle")
                    .onTapGesture {
                        modelData.selectedParameterID = zoneParam.parameter.id
                    }
                    .foregroundStyle(.customBlue)

                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(String(format: "%.2f", zoneParam.value))
                    .fontDesign(.monospaced)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    
                if let unit = zoneParam.parameter.unitOfMeasurement {
                    Text(unit)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            VStack {
                ForEach(zoneParam.currentValueInfo) { info in
                    ParameterInfoView(info: info)
                }
            }
            .padding(.bottom, 8)
        }
    }
}

