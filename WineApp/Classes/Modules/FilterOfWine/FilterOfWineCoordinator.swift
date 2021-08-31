//
//  FilterOfWine.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import UIKit

class FilterOfWineCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "FilterOfWine", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "FilterOfWineViewController") as? FilterOfWineViewController else { return }
        let viewModel = FilterOfWineViewModel(coordinator: self)
        controler.configure(viewModel: viewModel)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func navigateHomeScreen(filter: Filter) {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start(filter: filter)
    }
}
