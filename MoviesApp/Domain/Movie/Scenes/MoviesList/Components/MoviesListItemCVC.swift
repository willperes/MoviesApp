//
//  MoviesListItemCVC.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

protocol MoviesListItemCVCDelegate {
    func onCellTapped(movie: MovieModel) -> Void
}

class MoviesListItemCVC: UICollectionViewCell {
    static let identifier = "MoviesListItemCVC"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var movie: MovieModel?
    var delegate: MoviesListItemCVCDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell(withMovie movie: MovieModel?) {
        self.movie = movie
        imageView.image = nil
        
        guard let imageURL = movie?.imageURL else {
            return
        }
        
        UIImage().loadImage(from: imageURL) { image in
            self.imageView.image = image
        }
    }
    
    @objc func cellTapped() {
        print("Here")
        
        if let movie = self.movie {
            delegate?.onCellTapped(movie: movie)
        }
    }
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
