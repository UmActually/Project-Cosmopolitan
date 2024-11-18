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
            .navigationBarTitleDisplayMode(.large)
            .scrollContentBackground(.hidden)
            .background(LinearGradient(
                colors: [.zoneDetailTop, .customBlue.opacity(0.25)],
                startPoint: .top, endPoint: .bottom
            ))
            .sheet(isPresented: Binding(get: {
                modelData.selectedParameterID != nil
            }, set: {
                if !$0 {
                    modelData.selectedParameterID = nil
                }
            })) {
                GeneralInfoView()
                    .presentationDetents([.medium])
            }
            .onAppear {
                modelData.expandedParameterInfoID = nil
            }
    }
}

#Preview {
    let modelData = ModelData()
    modelData.selectedZone = modelData.naplesZones.first!
    return NavigationStack {
        ZoneDetail()
            .environmentObject(modelData)
    }
}
