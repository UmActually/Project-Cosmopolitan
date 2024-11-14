//
//  MapfountainsNaView.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 13/11/24.
//

import SwiftUI
import MapKit

struct MapfountainsNaView: View {
    ///Map Properties
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: MKMapItem?
    @Namespace private var locationSpace
    @State private var viewingRegion: MKCoordinateRegion?
    ///Search properties
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    ///Map Selection Detail Properties
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
    ///Route Properties
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    
    var body: some View {
        NavigationStack{
            Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
                
                ///Map annotations
                Annotation("Home", coordinate: .myLocation){
                    ZStack {
                        Image(systemName: "drop.fill")
                            .font(.title)
                    }
                }
                .annotationTitles(.hidden)
                
                ///Simply Display Annotation as Marker
                ForEach(searchResults, id: \.self) { mapItem in
                 ///Hidding All other Markers, Expect Destination one
                    if routeDisplaying {
                        if mapItem == routeDestination {
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                .tint(.blue)
                        }
                    } else {
                        let placemark = mapItem.placemark
                        Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                }
                
                ///Display Route using Polyline
                if let route {
                    MapPolyline(route.polyline)
                    ///Applying Bigger Stroke
                        .stroke(.blue, lineWidth: 7)
                }
                ///To show user current location
                UserAnnotation()
            }
            .onMapCameraChange({ ctx in
                viewingRegion = ctx.region
                
            })
            .overlay(alignment:.bottomTrailing){
                VStack(spacing: 15) {
                    MapCompass(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("Drinkable Fountains")
            ///Search Bar
            .searchable(text: $searchText, isPresented: $showSearch)
            ///Showing Translucent ToolBar
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            ///When route Displaying Hiding top and bottom bar
            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
            .sheet(isPresented: $showDetails, onDismiss: {
                withAnimation(.snappy) {
                    ///Zooming Route
                    if let boundingRect = route?.polyline.boundingMapRect {
                        cameraPosition = .rect(boundingRect)
                    }
                }
            }, content: {
                    MapDetails()
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough:.height(300)))
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled(true)
        })
        .safeAreaInset(edge: .bottom) {
            if routeDisplaying {
                Button("End Route") {
                    ///Closing The Route and Setting the Selection
                    withAnimation(.snappy){
                        routeDisplaying = false
                        showDetails = true
                        mapSelection = routeDestination
                        routeDestination = nil
                        route = nil
                        cameraPosition = .region(.myRegion)
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.red.gradient, in: .rect(cornerRadius: 15))
                .padding()
                .background(.ultraThinMaterial)
            }
        }
    }
        .onSubmit (of: .search) {
            Task {
                guard searchText.isEmpty else { return }
                
                await searchPlaces()
            }
        }
        .onChange(of: showSearch, initial: false) {
            if !showSearch {
                /// Clearing Search Results
                searchResults.removeAll(keepingCapacity: false)
                showDetails = false
                ///Zooming out to User Region when Search Cancelled
                withAnimation(.snappy) {
                    cameraPosition = .region(.myRegion)
                }
            }
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            ///Display Details about the Select Place
            showDetails = newValue != nil
            ///Fetching Look Around Preveiw, when ever selection Changes
            fetchLookAroundPreview()
        }
    }
    
    ///Map Details View
    @ViewBuilder
    func MapDetails() -> some View {
        VStack(spacing: 15) {
            ZStack{
                ///New Look Around API
                if lookAroundScene == nil {
                    ///New Empty View API
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                } else {
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            ///Close Button
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails = false
                    withAnimation(.snappy){
                        mapSelection = nil
                        
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white, in: .circle)
                })
                .padding(10)
            }
            
            ///Direction's Button
            Button("Get Directions",action: fetchRoute)                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.blue.gradient, in: .rect(cornerRadius: 15))
            }
        .padding(15)
    }
    
    /// Search Places
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = viewingRegion ?? .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    ///Fetching Location Preview
    func fetchLookAroundPreview() {
        if let mapSelection {
            ///Clearing Old One
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
        ///Fetching Route
        func fetchRoute() {
            if let mapSelection{
                let request = MKDirections.Request()
                request.source = .init(placemark: .init(coordinate: .myLocation))
                request.destination = mapSelection
                
                Task {
                    let result = try? await MKDirections(request: request).calculate()
                    route = result?.routes.first
                    ///Saving Route Destination
                    routeDestination = mapSelection
                    
                    withAnimation(.snappy) {
                        routeDisplaying = true
                        showDetails = false
                    }
                }
            }
        }
    }
#Preview {
    MapfountainsNaView()
}
extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 40.838986, longitude: 14.291757)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
