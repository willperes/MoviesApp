//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Willian Peres on 28/11/23.
//

import Foundation

struct MovieModel: Codable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
