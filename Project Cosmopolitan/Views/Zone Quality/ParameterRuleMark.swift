//
//  ParameterRuleMark.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 15/11/24.
//

import SwiftUI
import Charts

struct ParameterRuleMark: ChartContent {
    let value: Double
    let label: String
    
    var body: some ChartContent {
        RuleMark(
            x: .value(label, value)
        )
        .foregroundStyle(.gray)
        .annotation(position: .top, alignment: .center) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .annotation(position: .bottom, alignment: .center) {
            Text(String(format: "%.2f", value))
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
