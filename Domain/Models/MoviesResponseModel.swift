//
//  MoviesResponseModel.swift
//  MoviesApp
//
//  Created by Willian Peres on 28/11/23.
//

import Foundation

struct MoviesResponseModel: Codable {
    let page: Int
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}
