//
//  MovieResponseDTO.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import Foundation

struct MovieResponseDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
}
