//
//  ParameterListView.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

struct ParameterList: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        List {
            if let quality = modelData.selectedZone?.quality {
                Section {
                    ForEach(quality.prefix(9), id: \.parameterID) { zoneParam in
                        GraphParameterView(zoneParam: zoneParam)
                    }
                } header: {
                    Text("Chemical-physical parameters")
                }
                Section {
                    ForEach(quality.suffix(2), id: \.parameterID) { zoneParam in
                        TextParameterView(zoneParam: zoneParam)
                    }
                } header: {
                    Text("Microbiological parameters")
                }
            }
        }
    }
}
