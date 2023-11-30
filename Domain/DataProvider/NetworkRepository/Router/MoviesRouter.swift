//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Willian Peres on 28/11/23.
//

import Foundation

enum MoviesRouter {
    case upcoming(language: String, page: Int)
    
    var path: String {
        switch self {
        case .upcoming:
            return MoviesAPI.upcomingMovies
        }
    }
    
    func asURLRequest() throws -> URL? {
        guard let url = URL(string: MoviesAPI.baseURL) else { return nil }
        
        switch self {
        case .upcoming(let language, let page):
            let parameters: [String: String] = [
                "language": language,
                "page": String(page),
                "api_key": MoviesAPI.apiKey
            ]
            
            return url.appendingQueryParameters(path: path, parameters: parameters)
        }
    }
}
