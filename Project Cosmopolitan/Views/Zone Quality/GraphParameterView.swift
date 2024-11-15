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
    
    @State var showGeneralInfo = false
    @State private var expandedDescriptions: [String: Bool] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // Header with parameter name and detected value
                Text(zoneParam.parameter.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                // Info button to general info view
                Image(systemName: "info.circle")
                    .onTapGesture {
                        showGeneralInfo = true
                    }
                    .foregroundColor(.customBlue)

                Spacer()
                Text(String(format: "%.2f", zoneParam.value))
                    .font(.title2)
                    .foregroundColor(.secondary)
                    
                if let unit = zoneParam.parameter.unitOfMeasurement {
                    Text(unit)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            
            Chart {
                BarMark(
                    x: .value("Parameter", zoneParam.value)
                )
                .foregroundStyle(zoneParam.isWithinRange ? .lightGreen : .rustyRed) // Adjust color based on range
                
                if let min = zoneParam.parameter.minSuggestedValue, let max = zoneParam.parameter.maxSuggestedValue, zoneParam.parameter.benchmarkValue == nil {
                    // Min annotation
                    RuleMark(
                        x: .value("MinSuggestedValue", min)
                    )
                    .foregroundStyle(.gray)
                    .annotation(position: .top, alignment: .center) {
                        Text("min")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .annotation(position: .bottom, alignment: .center) {
                        Text(String(format: "%.2f", min))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Max annotation
                    RuleMark(
                        x: .value("MaxSuggestedValue", max)
                    )
                    .foregroundStyle(.gray)
                    .annotation(position: .top, alignment: .center) {
                        Text("Max")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .annotation(position: .bottom, alignment: .center) {
                        Text(String(format: "%.2f", max))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                if let benchmark = zoneParam.parameter.benchmarkValue,
                   benchmark != zoneParam.parameter.maxSuggestedValue {
                    RuleMark(
                        x: .value("Benchmark", benchmark)
                    )
                    .annotation(position: .top, alignment: .center) {
                        Text("Limit")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .annotation(position: .bottom, alignment: .center) {
                        Text(String(format: "%.2f", zoneParam.parameter.benchmarkValue ?? 0))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .foregroundStyle(.gray)
                }
            }
            .frame(height: 50)
            .chartXAxis { AxisMarks() { _ in } }
            
            // Display warning or success message based on the range
            Spacer()
            HStack {
                Image(systemName: zoneParam.isWithinRange ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                    .foregroundColor(zoneParam.isWithinRange ? .green : .red)
                Text(zoneParam.isWithinRange ? "Value is within the suggested range" : "Warning: Value is above the suggested range!")
                    .font(.system(size: 15))
                    .foregroundColor(zoneParam.isWithinRange ? .green : .red)
                
                Spacer()
                
                // Chevron button to toggle description visibility
                Button(action: {
                    expandedDescriptions[zoneParam.parameter.name, default: false].toggle()
                }) {
                    Image(systemName: expandedDescriptions[zoneParam.parameter.name, default: false] ? "chevron.down.circle.fill" : "chevron.right.circle.fill")
                        .foregroundColor(.customBlue)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure it behaves as a plain button without additional styles
            }
            
            // Conditionally show the description below the graph
            if expandedDescriptions[zoneParam.parameter.name, default: false] {
                Text("Description")
                    .font(.body)
                    .padding(.top, 8)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $showGeneralInfo) {
            GeneralInfoView()
        }
    }
}

// Add an extension or helper to ZoneParameter to determine if the value is within the suggested range
extension ZoneParameter {
    var isWithinRange: Bool {
        guard let min = parameter.minSuggestedValue, let max = parameter.maxSuggestedValue else {
            return true // Default to true if no range is defined
        }
        return value >= min && value <= max
    }
}

// Preview with dummy data
#Preview {
    GraphParameterView(zoneParam: ModelData().naplesZones[0].quality[0])
}

