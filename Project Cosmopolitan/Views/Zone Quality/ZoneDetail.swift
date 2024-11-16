//
//  ZoneDetail.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 08/11/24.
//

import SwiftUI

struct ZoneDetail: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ParameterList()
            .navigationTitle(modelData.selectedZone?.name ?? "No Zone")
    }
}
