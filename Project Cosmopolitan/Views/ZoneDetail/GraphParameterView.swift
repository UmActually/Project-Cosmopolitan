//
//  ParameterGraphVIew.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

struct ParameterGraphVIew: View {
    
    var body: some View {
        ScrollView {
            
            ForEach(ParameterViewModel().parameters) { parameter in
                VStack(alignment: .leading, spacing: 16) {
                    if parameter.showChart {
                        HStack{
                            Text(parameter.name + ":")
                                .font(.headline)
                                .foregroundColor(Color.blue)
                            Text((String(format: "%.2f", parameter.detectedValue)))
                             
                                
                        }
                        Chart {
                            BarMark(
                                x: .value("Parameter", parameter.detectedValue)
                            )
                            // Adding a benchmark line
                            RuleMark(
                                x: .value("Benchmark", parameter.benchmarkValue)
                            )
                        }
                        .frame(height: 50)
                    }
                }
            }
            .padding()
        }
    }
}

struct GraphParameterView: View {
    let parameter: ZoneParameter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(parameter.type.name + ":")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Text((String(format: "%.2f", parameter.value)))
            }
            Chart {
                BarMark(
                    x: .value("Parameter", parameter.value)
                )
                if let min = parameter.type.minSuggestedValue, let max = parameter.type.maxSuggestedValue {
                    RuleMark(
                        x: .value("MinSuggestedValue", min)
                    )
                    .foregroundStyle(.columbiaBlue)
                    RuleMark(
                        x: .value("MinSuggestedValue", max)
                    )
                    .foregroundStyle(.rustyRed)
                }
                if let benchmark = parameter.type.benchmarkValue,
                   benchmark != parameter.type.maxSuggestedValue {
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
