//
//  ParameterListView.swift
//  Project Cosmopolitan
//
//  Created by Luca Langella 1 on 13/11/24.
//

import SwiftUI

import SwiftUI

struct ParameterListView: View {
    
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

#Preview {
   ParameterListView()
}
