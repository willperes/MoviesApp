//
//  MoviesStore.swift
//  MoviesApp
//
//  Created by Willian Peres on 28/11/23.
//

import Foundation

protocol MoviesStoreProtocol: GenericStoreProtocol {
    func fetchMovies(language: String, page: Int, completion: @escaping completion<MoviesResponseModel?>)
}

class MoviesStore: GenericStoreRequest, MoviesStoreProtocol {
    func fetchMovies(language: String, page: Int, completion: @escaping completion<MoviesResponseModel?>) {
        do {
            guard let url = try MoviesRouter.upcoming(language: language, page: page).asURLRequest() else {
                return completion(nil, error)
            }
            
            request(url: url, completion: completion)
        } catch {
            completion(nil, error)
        }
    }
}
