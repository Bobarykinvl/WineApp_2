//
//  DescriptionWineViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 7.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class DescriptionWineViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let viewModel = DescriptionWineViewModel()
    private let bag = DisposeBag()
    private var model: Wine?
    private let fileManager = FileManagerWine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func configure(model: Wine) {
        self.model = model
    }
}

// MARK: Setup
extension DescriptionWineViewController {
    
    func setup() {
        image.image = fileManager.readImageInTmpFolder(by: URL(string: model!.image)!.lastPathComponent)
        nameLabel.text = model?.name
        priceLabel.text = (String(describing: model?.price))
    }
}
