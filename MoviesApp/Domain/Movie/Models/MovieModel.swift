//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import Foundation

struct MovieModel {
    let id: Int
    let title: String
    let description: String
    let imageURL: String?
    
    static func from(_ movieDTO: MovieResponseDTO) -> MovieModel {
        let imageURL = movieDTO.poster_path != nil ? "https://image.tmdb.org/t/p/w185\(movieDTO.poster_path!)" : nil
        return MovieModel(id: movieDTO.id, title: movieDTO.title, description: movieDTO.overview, imageURL: imageURL)
    }
}
