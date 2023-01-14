//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 06/01/2023.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valide code, magnitude, place or time", comment: "")
        case .networkError:
            return NSLocalizedString("Network error", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
