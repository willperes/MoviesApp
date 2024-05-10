//
//  UIImage.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

extension UIImage {
    private func loadImage(from rawURL: String, completion: @escaping (_ image: UIImage) -> Void) -> Void {
        if let cachedImage = ImageCache.shared.get(forKey: rawURL) {
            return completion(cachedImage)
        }
        
        guard let url = URL(string: rawURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.set(image, forKey: rawURL)
                return completion(image)
            }
        }
        task.resume()
    }
}
