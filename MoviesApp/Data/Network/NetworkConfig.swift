//
//  NetworkConfig.swift
//  MoviesApp
//
//  Created by Willian Peres on 10/05/24.
//

import Foundation

struct NetworkConfig {
    struct Movies {
        static let apiKeyParam = URLQueryItem(name: "api_key", value: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        
        static let pathUpcoming = "upcoming"
    }
}
