//
//  FooterCollectionReusableView.swift
//  RickAndMorty
//
//  Created by GrowApp on 17.08.2021.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "FooterCollectionReusableView"
    
    public func configure() {
        backgroundColor = .systemBackground
    }
    
    func layoutSubview() {
        super.layoutSubviews()
    }
}
