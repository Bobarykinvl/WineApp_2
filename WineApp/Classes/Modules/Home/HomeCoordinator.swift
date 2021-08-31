//
//  HomeCoordinator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(filter: Filter) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        let viewModel = HomeViewModel(coordinator: self)
        viewModel.configureFilter(filter: filter)
        controler.configure(viewModel: viewModel)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func navigateAddWineScreen() {
        let addWineCoordinator = AddWineCoordinator(navigationController: navigationController)
        addWineCoordinator.start()
    }
    
    func navigateFilterWineScreen() {
        let filterOfWineCoordinator = FilterOfWineCoordinator(navigationController: navigationController)
        filterOfWineCoordinator.start()
    }
    
    func navigateDescriptionWineScreen(model: Wine) {
        let nextCoordinator = DescriptionWineCoordinator(navigationController: navigationController)
        nextCoordinator.start(model: model)
    }
}
