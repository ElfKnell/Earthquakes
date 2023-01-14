//
//  CacheEntryObject.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 07/01/2023.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
