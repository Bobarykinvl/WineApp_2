//
//  WineTableViewCell.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 6.08.21.
//

import UIKit

class WineTableViewCell: UITableViewCell {

    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
