//
//  MoviesListWorker.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MoviesListWorkerProtocol {
    typealias Completion<D> = (_ result: D?, _ error: Error?) -> Void
    
    func fetchInitialData(_ completion: @escaping Completion<MoviesListResponseDTO>) async -> Void
}

class MoviesListWorker: MoviesListWorkerProtocol {
    private let config = NetworkConfig.Movies.self
    
    func fetchInitialData(_ completion: @escaping Completion<MoviesListResponseDTO>) async -> Void {
        let endpoint = NetworkEndpoint(
            baseURL: config.baseURL,
            path: config.pathUpcoming,
            method: NetworkEndpoint.Method.GET,
            parameters: [config.apiKeyParam])
        
        do {
            let response: MoviesListResponseDTO = try await NetworkManager.shared.getData(from: endpoint)
            completion(response, nil)
        } catch {
            completion(nil, error)
        }
    }
}
