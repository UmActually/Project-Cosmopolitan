//
//  ParameterGraphVIew.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    return formatter
}()

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
                    .fontDesign(.monospaced)
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
            .chartXScale(domain: zoneParam.parameter.domain)
            .chartXAxis {
                let domain = zoneParam.parameter.domain
                
                // MEXICANADA GRANDÍSIMA, SI SE PUEDE CAMBIAR DESPUÉS
                let almostUpperBound = domain.upperBound - (domain.upperBound - domain.lowerBound) * 0.08
                AxisMarks(values: [domain.lowerBound, almostUpperBound]) { value in
                    AxisValueLabel(numberFormatter.string(from: (value.index == 0 ? domain.lowerBound : domain.upperBound) as NSNumber)!)
                }
            }
            .frame(height: 40)
            
            VStack {
                ForEach(zoneParam.currentValueInfo, id: \.range) { info in
                    ParameterInfoView(info: info)
                }
            }
            .padding(.bottom, 8)
        }
    }
}
