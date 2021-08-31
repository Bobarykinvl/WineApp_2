//
//  HomeViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit
import RxSwift
import RxCocoa


class  HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addWineButton: UIBarButtonItem!
    @IBOutlet private weak var filterButton: UIButton!
    
    private let fileManager = FileManagerWine()
    private let userStorage = RealmStorage()
    private var viewModel: HomeViewModel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    func configure(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: Setup
extension HomeViewController {
    
    func setup() {
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: Binding
extension HomeViewController {
    
    func bind() {
        tableView.tableFooterView = UIView()
    
        let input = HomeViewModel.Input(addWineScreenOpen: addWineButton.rx.tap.asDriver(), filterWineScreenOpen: filterButton.rx.tap.asDriver(), selectedModel: tableView.rx.modelSelected(Wine.self).asDriver())
        let output = viewModel?.transform(input: input)
        output?.dataSource.drive(tableView.rx.items(cellIdentifier: "Cell")) {_,wine,cell in
                        if let cell = cell as? WineTableViewCell {
                            cell.wineImageView.image = self.fileManager.readImageInTmpFolder(by: URL(string: wine.image)!.lastPathComponent)
                            cell.nameLabel.text = wine.name
                            cell.priceLabel.text = String(wine.price)
                        }
                    }.disposed(by: bag)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            self.userStorage.removeWine(by:indexPath)
        }).disposed(by: bag)
      
        
//        Observable
//            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Wine.self))
//            .bind { [unowned self] indexPath, model in
//                self.tableView.deselectRow(at: indexPath, animated: true)
//                print("Selected \(model) and \(indexPath)")
//            }
//            .disposed(by: bag)
        
//        tableView.rx.modelSelected(Wine.self).subscribe(onNext: { model in
//                   print (model)
//                }).disposed(by: bag)
        
//        tableView.rx
//          .modelSelected(String.self)
//          .subscribe(onNext: { model in
//            print("\(model) was selected")
//          }).disposed(by: bag)
//
//            { indexPath in
//                return output?.dataSource.map({ wineModel in
//                    print ( "Моделька \(wineModel[indexPath.row])")
//                })
//            }.disposed(by: bag)
    }
}
