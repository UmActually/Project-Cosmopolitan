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
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(zoneParam.parameter.name + ":")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Text((String(format: "%.2f", zoneParam.value)))
            }
            Chart {
                BarMark(
                    x: .value("Parameter", zoneParam.value)
                )
                if let min = zoneParam.parameter.minSuggestedValue, let max = zoneParam.parameter.maxSuggestedValue {
                    RuleMark(
                        x: .value("MinSuggestedValue", min)
                    )
                    .foregroundStyle(.columbiaBlue)
                    RuleMark(
                        x: .value("MinSuggestedValue", max)
                    )
                    .foregroundStyle(.rustyRed)
                }
                if let benchmark = zoneParam.parameter.benchmarkValue,
                   benchmark != zoneParam.parameter.maxSuggestedValue {
                    RuleMark(
                        x: .value("Benchmark", benchmark)
                    )
                    .foregroundStyle(.jet)
                }
            }
            .frame(height: 50)
        }
    }
}
