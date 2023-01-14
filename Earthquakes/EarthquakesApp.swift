//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 06/01/2023.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    
    @StateObject var quakersProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakersProvider)
        }
    }
}
