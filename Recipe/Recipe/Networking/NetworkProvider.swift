//
//  NetworkProvider.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/21/25.
//

import Foundation

protocol NetworkProviding {
    /// This function retrives data from remote url
    /// - Parameters:
    ///   - urlString: String value of the remote url
    /// - Returns: Data -
    func fetchDataFrom(urlString: String) async throws -> Data?
}

struct NetworkProvider: NetworkProviding {
    
    func fetchDataFrom(urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
    
