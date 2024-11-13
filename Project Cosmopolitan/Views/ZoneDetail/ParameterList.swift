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
                    GraphParameterView(parameter: quality.hardness)
                    GraphParameterView(parameter: quality.ph)
                    GraphParameterView(parameter: quality.dryResidue)
                    GraphParameterView(parameter: quality.nitrate)
                    GraphParameterView(parameter: quality.nitrite)
                    GraphParameterView(parameter: quality.ammonium)
                    GraphParameterView(parameter: quality.fluoride)
                    GraphParameterView(parameter: quality.chloride)
                    GraphParameterView(parameter: quality.conductivity)
                } header: {
                    Text("Chemical-physical parameters")
                }
                Section {
                    TextParameterView(parameter: quality.coliformBacteria)
                    TextParameterView(parameter: quality.eColi)
                } header: {
                    Text("Microbiological parameters")
                }
            }
        }
    }
}


struct _ParameterList: View {
     var parameterVM = ParameterViewModel()
    @State var showModal: Bool = false
    
    var body: some View {
        
        NavigationStack {
            // View of all parameters
            List {
                Section(header: Text("Chemical-physical parameters")) {
                    SuggestedGraphView()
                    ParameterGraphVIew()
                }
                Section(header: Text("Microbiological parameters")) {
                    MicrobiologicalParametersView()
                }
            }
            // Status Indicator
                .overlay {
                    VStack {
                        Spacer()
                        ZStack(alignment: .top) {
                            Rectangle()
                                .cornerRadius(8)
                                .shadow(radius: 10, x: 0, y: 10)
                                .foregroundStyle(Color.white)
                            VStack{
                                Text("Acceptable")
                                    .font(.title)
                                    .foregroundColor(Color.blue)
                            }
                            .padding(.top, 20)
                        }
                        .frame(height: 120)
                    }
                    .ignoresSafeArea()
                }
                .navigationTitle("Water Quality")
        }
    }
}
