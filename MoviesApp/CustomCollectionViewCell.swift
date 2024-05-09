//
//  CustomCollectionViewCell.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

protocol CustomCollectionViewCellDelegate {
    func onCellTapped(color: UIColor) -> Void
}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    var color: UIColor?
    var delegate: CustomCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell(color: UIColor) {
        self.color = color
        contentView.backgroundColor = self.color
    }
    
    @objc func cellTapped() {
        delegate?.onCellTapped(color: self.color ?? .black)
    }
}
