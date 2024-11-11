//
//  HomeSheet.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 11/11/24.
//

import SwiftUI

struct HomeSheet: View {
    @Binding var selectedZone: Zone?
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Text("Zones of Naples")
                    .bold()
                    .font(.title3)
                    .padding(.bottom, 6)
                ForEach(MapViewModel.naplesZones) { zone in
                    Button(action: { selectedZone = zone }) {
                        ZoneListCard(zone: zone)
                    }
                }
            }
            .padding(.top)
            .padding()
        }
    }
}
