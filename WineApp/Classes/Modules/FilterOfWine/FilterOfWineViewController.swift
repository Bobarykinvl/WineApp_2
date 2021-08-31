//
//  FilterOfWineController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FilterOfWineViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    private var viewModel: FilterOfWineViewModel?
    private let bag = DisposeBag()
    private let filter: Filter = Filter.date
    
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var filterRelay = PublishRelay<Filter>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func configure(viewModel: FilterOfWineViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: Binding
extension FilterOfWineViewController {
    
    func bind() {
        
        let input = FilterOfWineViewModel.Input(choosedFilter: collectionView.rx.modelSelected(String.self).map { Filter(rawValue: $0) ?? .date
        }.asDriver(onErrorJustReturn: Filter.date))
        
        let output = viewModel?.transform(input: input)
        output?.dataSource.drive(collectionView.rx.items(cellIdentifier: "Cell")) { row,element,cell in
            if let cell = cell as? FilterOfWineCollectionViewCell {
                cell.nameOfFilter.text = element
            }
        }.disposed(by: bag)
        
//        collectionView.rx.modelSelected(String.self).subscribe(onNext: { model in
//            self.filterRelay.accept(self.filter.byName(value: model))
//        }).disposed(by: bag)
        
    }
    
    
}

    

