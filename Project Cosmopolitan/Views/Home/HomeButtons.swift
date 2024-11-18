//
//  ZonesMapButton.swift
//  Project Cosmopolitan
//
//  Created by Leonardo Corona Garza on 17/11/24.
//

import SwiftUI
import MapKit

struct HelpButton: View {
    @State private var isExpanded: Bool = false
    
    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.4)) {
                isExpanded.toggle()
            }
        } label: {
            ZStack {
                if isExpanded {
                    (Text("Tap on a ") + Text("zone").fontWeight(.heavy) + Text(" of the map to discover the quality of its water. Tap on the ") + Text("fountains").fontWeight(.heavy) + Text(" icon to explore public water sources."))
                        .multilineTextAlignment(.trailing)
                        .font(.subheadline)
                        .padding()
                        .padding(.horizontal)
                        .frame(minHeight: 60)
                } else {
                    Image(systemName: "questionmark")
                        .fontWeight(.medium)
                        .frame(width: 60, height: 60)
                }
            }
            .background(.backgroundDefault)
        }
        .foregroundStyle(.customBlue)
        .frame(minWidth: 60, minHeight: 60)
        .clipShape(RoundedRectangle(cornerRadius: 999))
        .shadow(color: .black.opacity(0.4), radius: 10)
    }
}

struct GoToLocationButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "location")
                .fontWeight(.medium)
        }
        .foregroundStyle(.customBlue)
        .frame(width: 60, height: 60)
        .background(.backgroundDefault)
        .clipShape(Circle())
        .shadow(color: .black.opacity(0.4), radius: 10)
    }
}

struct ToggleFountainsButton: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showMessage = false
    
    var body: some View {
        Button {
            modelData.showingFountains.toggle()
            withAnimation(.spring(duration: 0.4)) {
                showMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.spring(duration: 0.4)) {
                    showMessage = false
                }
            }
            // Zoom to actually see fountains/zones
            if modelData.mkMapView.region.span.latitudeDelta > 0.06 {
                modelData.moveCameraRegion = true
                modelData.cameraRegion.center = modelData.mkMapView.region.center
                modelData.cameraRegion.span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                DispatchQueue.main.async {
                    modelData.moveCameraRegion = false
                }
            }
        } label: {
            if showMessage {
                (Text("Showing ") + Text(modelData.showingFountains ? "fountains" : "zones").fontWeight(.heavy))
                    .padding()
                    .padding(.horizontal)
                    .frame(minHeight: 60)
            } else {
                Image("FountainIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
            }
        }
        .frame(minWidth: 60, minHeight: 60)
        .background(.backgroundDefault)
        .clipShape(RoundedRectangle(cornerRadius: 999))
        .shadow(color: .black.opacity(0.4), radius: 10)
    }
}
