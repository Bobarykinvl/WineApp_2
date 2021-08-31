//
//  HomeViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import RxSwift
import RxCocoa

class HomeViewModel {
        
    private var filter: Filter = Filter.date
    private let userStorage = RealmStorage()
    private let coordinator: HomeCoordinator
    private let bag = DisposeBag()
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func configureFilter(filter: Filter) {
        self.filter = filter
    }
}

// MARK: ViewModelType
extension HomeViewModel: ViewModelType {
    
    struct Input {
        var addWineScreenOpen: Driver<Void>
        var filterWineScreenOpen: Driver<Void>
        var selectedModel: Driver<Wine>
    }
    
    struct Output {
        var dataSource: Driver<[Wine]>
    }
    
    func transform(input: Input) -> Output {
        input.filterWineScreenOpen.drive(onNext: { [weak self] in
            self?.coordinator.navigateFilterWineScreen()
        }).disposed(by: bag)
        
        input.addWineScreenOpen.drive(onNext: { [weak self] in
            self?.coordinator.navigateAddWineScreen()
        }).disposed(by: bag)
        
        var dataSource = userStorage.getListOfWine()
        
        switch filter {
        case .name:
             dataSource = userStorage.getListOfWine().map {
                $0.sorted(by:{$0.name > $1.name})
             }
        case .price:
              dataSource = userStorage.getListOfWine().map {
                $0.sorted(by:{$0.price > $1.price})
              }
        case .date:
             dataSource = userStorage.getListOfWine()
        }
        
        input.selectedModel.drive(onNext: { [weak self] model in
            self?.coordinator.navigateDescriptionWineScreen(model: model)
        }).disposed(by: bag)
            return Output(dataSource: dataSource)
    }
}

