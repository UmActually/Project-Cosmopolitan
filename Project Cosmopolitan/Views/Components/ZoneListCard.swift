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
        VStack {
            Text(zone.name)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(zone.neighborhood)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .multilineTextAlignment(.leading)
    }
}
