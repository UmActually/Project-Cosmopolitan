//
//  ZonesMapButton.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 17/11/24.
//

import SwiftUI

struct ZonesMapButton: View {
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .fontWeight(.medium)
        }
        .foregroundStyle(.customBlue)
        .frame(width: 60, height: 60)
        .background(.backgroundDefault)
        .clipShape(Circle())
        .shadow(color: .black.opacity(0.4), radius: 10)
    }
}
