//
//  ParameterGraphVIew.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

struct GraphParameterView: View {
    let zoneParam: ZoneParameter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .firstTextBaseline) {
                // Header with parameter name and detected value
                Text(zoneParam.parameter.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                // Info button to general info view
                Image(systemName: "info.circle")
                    .onTapGesture {
                        // TODO: Navigate
                    }
                    .foregroundStyle(.customBlue)

                Spacer()
                Text(String(format: "%.2f", zoneParam.value))
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    
                if let unit = zoneParam.parameter.unitOfMeasurement {
                    Text(unit)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Chart {
                BarMark(
                    x: .value("Parameter", zoneParam.value)
                )
                .foregroundStyle(zoneParam.isWithinRange ? .lightGreen : .rustyRed) // Adjust color based on range
                
                if let benchmark = zoneParam.parameter.upperBound,
                   zoneParam.parameter.lowerBound == nil {
                    ParameterRuleMark(value: benchmark, label: "Limit")
                } else if let lower = zoneParam.parameter.lowerBound,
                   let upper = zoneParam.parameter.upperBound {
                    ParameterRuleMark(value: lower, label: "Min")
                    ParameterRuleMark(value: upper, label: "Max")
                }
            }
            .frame(height: 40)
            
            ForEach(zoneParam.currentValueInfo, id: \.range) { info in
                ParameterInfoView(info: info)
            }
        }
    }
}
