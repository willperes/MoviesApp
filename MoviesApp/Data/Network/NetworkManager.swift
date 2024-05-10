//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Willian Peres on 10/05/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData<D: Decodable>(from endpoint: NetworkEndpoint) async throws -> D
    func sendData<D: Decodable, E: Encodable>(from endpoint: NetworkEndpoint, with body: E) async throws -> D
}

final class NetworkManager: NetworkManagerProtocol {
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    static let shared: NetworkManager = NetworkManager()
    
    private let session = URLSession.shared
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func getData<D: Decodable>(from endpoint: NetworkEndpoint) async throws -> D {
        let request = try createRequest(from: endpoint)

        let response: NetworkResponse = try await session.data(for: request)
        return try decoder.decode(D.self, from: response.data)
    }
    
    func sendData<D: Decodable, E: Encodable>(from endpoint: NetworkEndpoint, with body: E) async throws -> D {
        let request = try createRequest(from: endpoint)
        let data = try encoder.encode(body)
        let response: NetworkResponse = try await session.upload(for: request, from: data)
        return try decoder.decode(D.self, from: response.data)
    }
    
    private func createRequest(from endpoint: NetworkEndpoint) throws -> URLRequest {
        guard
            let urlPath = URL(string: endpoint.baseURL.appending(endpoint.path)),
            var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: true)
        else {
            throw NetworkError.invalidPath
        }
        
        if let parameters = endpoint.parameters {
            urlComponents.queryItems = parameters
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (name, value) in headers {
                request.setValue(name, forHTTPHeaderField: value)
            }
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

