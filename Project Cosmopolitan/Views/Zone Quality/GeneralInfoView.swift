//
//  General_info.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella on 16/11/24.
//

import SwiftUI

struct GeneralInfoView: View {
    @ObservedObject var generalInfoModel = GeneralInfoModel()
    var selectedParameter: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List($generalInfoModel.generalInfo) { $item in
                if item.title == selectedParameter {
                    Section {
                        Text(item.detailText)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                    } header: {
                        Text(item.title)
                            .font(.headline)
                            .foregroundStyle(.customBlue)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "xmark.circle.fill") // This line is already correct
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                        .padding(6)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
        }
    }
}


#Preview {
    GeneralInfoView(selectedParameter: "pH")
}
