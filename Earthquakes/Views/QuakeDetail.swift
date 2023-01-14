//
//  QuakeDetail.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 08/01/2023.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    
    @EnvironmentObject private var quakesProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            
            QuakeMagnitude(quake: quake)
            
            Text(quake.place)
                .font(.title3)
                .bold()
            
            Text("\(quake.time.formatted())")
                .foregroundColor(.secondary)
            
            if let location = self.location {
                Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                
                Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(from: quake)
                }
            }
        }
    }
}

struct QuakeDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuakeDetail(quake: Quake.preview)
    }
}
