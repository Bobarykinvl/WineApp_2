//
//  FilterOfWineCollectionViewCell.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 23.08.21.
//

import UIKit

class FilterOfWineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameOfFilter: UILabel!
}

// MARK: Setup Cell
extension FilterOfWineCollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
////        self.layer.cornerRadius = 9
//        self.layer.shadowRadius = 9
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: 9, height: 5)
    }
}
