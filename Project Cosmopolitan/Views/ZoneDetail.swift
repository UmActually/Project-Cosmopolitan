//
//  ZoneDetail.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI

struct ZoneDetail: View {
    let zone: Zone?
    
    var body: some View {
        Text(zone?.name ?? "No Zone")
            .navigationTitle(zone?.name ?? "No Zone")
    }
}
