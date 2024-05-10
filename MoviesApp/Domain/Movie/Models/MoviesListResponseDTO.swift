//
//  MoviesListResponseDTO.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import Foundation

struct MoviesListResponseDTO: Decodable {
    let page: Int
    let total_pages: Int
    let results: [MovieResponseDTO]
}
