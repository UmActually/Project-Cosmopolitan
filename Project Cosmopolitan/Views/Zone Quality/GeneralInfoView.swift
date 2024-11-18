//
//  General_info.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 11/11/24.
//

import SwiftUI

struct GeneralInfoView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack {
            if let id = modelData.selectedParameterID {
                let info = modelData.generalInfo[id - 1]
                List {
                    Section {
                        Text(info.detailText)
                    } header: {
                        Text("Detail")
                    }
                }
                .navigationTitle(info.title)
            }
        }
    }
}

#Preview {
    GeneralInfoView()
}
