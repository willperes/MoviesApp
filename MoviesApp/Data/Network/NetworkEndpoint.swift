//
//  NetworkEndpoint.swift
//  MoviesApp
//
//  Created by Willian Peres on 10/05/24.
//

import Foundation

struct NetworkEndpoint {
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    let baseURL: String
    let path: String
    let method: Method
    let parameters: [URLQueryItem]?
    let headers: [(name: String, value: String)]?
    
    init(baseURL: String, path: String, method: Method, parameters: [URLQueryItem]?, headers: [(name: String, value: String)]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

