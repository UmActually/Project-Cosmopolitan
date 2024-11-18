//
//  ParameterInfoView.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 15/11/24.
//

import SwiftUI

struct ParameterInfoDialog: View {
    let info: ParameterInfo
    
    @EnvironmentObject var modelData: ModelData
    
    var isExpanded: Bool {
        modelData.expandedParameterInfoID == info.id
    }
    
    var textColor: Color {
        if isExpanded {
            return .textDefault
        }
        return info.isPositive ? .darkGreen : .darkWarningOrange
    }
    
    var strokeColor: Color {
        info.isPositive ? .lightGreen : .warningOrange
    }
    
    var iconName: String {
        if info.isPositive {
            return isExpanded ? "drop.circle.fill" : "checkmark.circle.fill"
        } else {
            return isExpanded ? "drop.triangle.fill" : "exclamationmark.triangle.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: iconName)
                    .foregroundStyle(strokeColor)
                    .contentTransition(.symbolEffect(.replace))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(info.description)
                        .lineLimit(isExpanded ? nil : 1)
                        .foregroundStyle(textColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isExpanded, let tips = info.tips, !tips.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Suggestions")
                                .bold()
                                .font(.subheadline.smallCaps())
                                .foregroundStyle(.customBlue)
                            
                            ForEach(tips, id: \.self) { tip in
                                Text(tip)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.bottom, 6)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            HStack {
                if isExpanded, let reference = info.reference {
                    let url = URL(string: reference)!
                    SmallLabel(text: "learn more", systemImage: "link")
                        .onTapGesture {
                            UIApplication.shared.open(url)
                        }
                }
                Spacer()
                SmallLabel(text: "see \(isExpanded ? "less" : "more")", systemImage: "chevron.\(isExpanded ? "up" : "down")")
                    .contentTransition(.symbolEffect(.replace))
                    .onTapGesture {
                        modelData.expandedParameterInfoID = isExpanded ? nil : info.id
                    }
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(isExpanded ? .clear : strokeColor.opacity(0.05))
                    .foregroundStyle(strokeColor.opacity(0.05))
                RoundedRectangle(cornerRadius: 10)
                    .stroke(strokeColor, lineWidth: 1)
            }
        )
        .onTapGesture {
            modelData.expandedParameterInfoID = isExpanded ? nil : info.id
        }
    }
}

struct SmallLabel: View {
    let text: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
            Text(text)
        }
        .font(.caption2)
        .foregroundColor(.customBlue)
    }
}
