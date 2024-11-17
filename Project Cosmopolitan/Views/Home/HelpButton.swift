//
//  HelpButton.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 17/11/24.
//

import SwiftUI

struct HelpButton: View {
    @State private var isExpanded: Bool = false
    
    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.4)) {
                isExpanded.toggle()
            }
        } label: {
            ZStack {
                if isExpanded {
                    Text("Tap on a zone of the map to discover the quality of its water.")
                        .multilineTextAlignment(.trailing)
                        .font(.subheadline)
                        .padding()
                        .padding(.horizontal)
                        .frame(minHeight: 60)
                } else {
                    Image(systemName: "questionmark")
                        .fontWeight(.medium)
                        .frame(width: 60, height: 60)
                }
            }
            .background(.backgroundDefault)
        }
        .foregroundStyle(.customBlue)
        .frame(minWidth: 60, minHeight: 60)
        .clipShape(RoundedRectangle(cornerRadius: 999))
        .shadow(color: .black.opacity(0.4), radius: 10)
    }
}

#Preview {
    HelpButton()
}
