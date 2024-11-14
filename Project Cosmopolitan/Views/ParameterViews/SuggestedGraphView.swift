//
//  SuggestedGraphView.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI
import Charts

struct SuggestedGraphView: View {
    var body: some View {
        ForEach(ParameterViewModel().parameters) { parameter in
            if parameter.MinSuggestedValue != 0 && parameter.MaxSuggestedValue != 0 {
                VStack(alignment: .leading, spacing: 16) {
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
                       
                        // Adding min suggested value line
                        RuleMark(
                            x: .value("MinSuggestedValue", parameter.MinSuggestedValue)
                        )
                        .foregroundStyle(.red)
                        // Adding Max suggested value line
                        RuleMark(
                            x: .value("MaxSuggestedValue", parameter.MaxSuggestedValue)
                        )
                        .foregroundStyle(.red)
                    }
                    .frame(height: 50)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SuggestedGraphView()
}

