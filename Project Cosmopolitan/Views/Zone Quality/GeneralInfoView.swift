//
//  General_info.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 11/11/24.
//

import SwiftUI

struct GeneralInfoView: View {
    @ObservedObject var generalInfoModel = GeneralInfoModel()
    
    var body: some View {
        List($generalInfoModel.generalInfo) { $item in
            Section {
                if item.isExpanded {
                    Text(item.detailText)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            } header: {
                Button {
                    withAnimation {
                        item.isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text(item.title)
                            .font(.headline)
                            .foregroundStyle(.accent)
                        Spacer()
                        Image(systemName: item.isExpanded ? "chevron.down" : "chevron.right")
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .navigationTitle("General Information")
    }
}

#Preview {
    GeneralInfoView()
}
