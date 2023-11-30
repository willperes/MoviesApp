//
//  LoadingFooterCollectionReusableView.swift
//  MoviesApp
//
//  Created by Willian Peres on 29/11/23.
//

import UIKit

class LoadingFooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "LoadingFooterCollectionReusableView"
    
    public func configure() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        addSubview(footerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
