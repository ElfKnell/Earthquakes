//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by Andrii Kyrychenko on 07/01/2023.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakesData
    }
}
