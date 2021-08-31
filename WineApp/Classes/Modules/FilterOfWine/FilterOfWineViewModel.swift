//
//  FilterOfWineViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import RxSwift
import RxCocoa

class FilterOfWineViewModel {
    
    var filter = ["Filter by price", "Filter by name", "Filter by date"]
    
    private let coordinator: FilterOfWineCoordinator
    private let bag = DisposeBag()
    
    init(coordinator: FilterOfWineCoordinator) {
        self.coordinator = coordinator
    }
}

extension FilterOfWineViewModel: ViewModelType {
    
    struct Input {
        var choosedFilter: Driver<Filter>
    }
    
    struct Output {
        var dataSource: Driver<[String]>
//        var choosedFilter: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        input.choosedFilter.drive { [weak self] filter in
            self?.coordinator.navigateHomeScreen(filter: filter)
        }.disposed(by: bag)
        
        let dataSource = Driver.just(filter)
        return Output(dataSource: dataSource)
    }
}
