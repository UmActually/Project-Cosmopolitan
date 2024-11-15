//
//  ParameterInfoView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 15/11/24.
//

import SwiftUI

struct ParameterInfoView: View {
    let info: ParameterInfo
    
    @State private var isExpanded = false
    
    var textColor: Color {
        if isExpanded {
            return .black
        }
        return info.isPositive ? .darkGreen : .darkRustyRed
    }
    
    var strokeColor: Color {
        info.isPositive ? .lightGreen : .rustyRed
    }
    
    var iconName: String {
        if info.isPositive {
            return isExpanded ? "drop.circle.fill" : "checkmark.circle.fill"
        } else {
            return isExpanded ? "drop.triangle.fill" : "exclamationmark.triangle.fill"
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
                .foregroundStyle(strokeColor)
                .contentTransition(.symbolEffect(.replace))
            
            VStack(alignment: .leading, spacing: 10) {
                Text(info.description)
                    .lineLimit(isExpanded ? nil : 1)
                    .foregroundStyle(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .animation(nil, value: isExpanded)
                
                if isExpanded, let tips = info.tips, !tips.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Suggestions")
                            .bold()
                            .font(.subheadline.smallCaps())
                            .foregroundStyle(.customBlue)
                        
                        ForEach(tips, id: \.self) { tip in
                            Text(tip)
                                .font(.caption2)
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Text("see \(isExpanded ? "less" : "more")")
                        .font(.caption2)
                        .foregroundStyle(.customBlue)
                }
            }
        }
    
        .contentShape(Rectangle())
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10)
//                    .foregroundStyle(isExpanded ? .clear : strokeColor.opacity(0.05))
                    .foregroundStyle(strokeColor.opacity(0.05))
                RoundedRectangle(cornerRadius: 10)
                    .stroke(strokeColor.opacity(0.2), lineWidth: 2)
            }
        )
        .onTapGesture {
            withAnimation(.spring(duration: 0.5)) {
                isExpanded.toggle()
            }
        }
    }
}
