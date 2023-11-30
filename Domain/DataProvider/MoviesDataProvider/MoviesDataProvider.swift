//
//  MoviesDataProvider.swift
//  MoviesApp
//
//  Created by Willian Peres on 28/11/23.
//

import Foundation

protocol MoviesDataProviderDelegate: GenericDataProviderDelegate {}

class MoviesDataProvider: GenericDataProviderManager<MoviesDataProviderDelegate, [MovieModel]> {
    private let store: MoviesStoreProtocol?
    
    init(moviesStore store: MoviesStoreProtocol = MoviesStore()) {
        self.store = store
    }
    
    func fetchMovies(language: String, page: Int) {
        store?.fetchMovies(language: language, page: page, completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            
            if let result {
                self.delegate?.success(model: result.results)
            }
        })
    }
}
