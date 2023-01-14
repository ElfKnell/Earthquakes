//
//  QuakeDetailMap.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 08/01/2023.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    
    private var plase: QuakePlace
    
    @State private var region = MKCoordinateRegion()
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.plase = QuakePlace(location: location)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [plase]) { plase in
            MapMarker(coordinate: plase.location, tint: tintColor)
        }
            .onAppear {
                withAnimation {
                    region.center = plase.location
                    region.span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                }
            }
    }
    
    struct QuakePlace: Identifiable {
        let id: UUID
        let location: CLLocationCoordinate2D
        
        init(id: UUID = UUID(), location: QuakeLocation) {
            self.id = id
            self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
    }
}
