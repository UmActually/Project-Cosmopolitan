//
//  ZoneListCard.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 11/11/24.
//

import SwiftUI

struct ZoneListCard: View {
    let zone: Zone
    
    var body: some View {
        HStack {
            Text(zone.id)
            Text(zone.name)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .multilineTextAlignment(.leading)
        .foregroundStyle(.black)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(LinearGradient(colors: [.aliceBlue, .white], startPoint: .leading, endPoint: .trailing))
                .shadow(color: .black.opacity(0.08), radius: 6)
        )
    }
}
