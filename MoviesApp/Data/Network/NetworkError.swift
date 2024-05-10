//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Willian Peres on 10/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidPath
    case invalidUrl
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .invalidPath:
            return "Invalid Path"
        case .invalidUrl:
            return "Invalid URL"
        case .decoding:
            return "There was an error decoding the type"
        }
    }
}
