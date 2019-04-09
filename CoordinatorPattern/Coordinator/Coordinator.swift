//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 26.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    /// Presents the `ViewItemSceneController`
    /// which is also the start viewController
    func start()
    /// Presents the `imageItemSceneController`
    var imageItemSceneController: Binder<ViewItemRow> { get }
}


class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = false
    }
    
    func start() {
        let client = APIClient.shared
        let provider = ViewItemProvider(client)
        let viewModel = ViewItemViewModel(provider)
        let scene = ViewItemSceneController(viewModel, self)
        navigationController.pushViewController(scene, animated: false)
    }
    
    var imageItemSceneController: Binder<ViewItemRow> {
        return Binder(self) { coordinator, row in
            let viewModel = ImageSceneViewModel(row)
            let scene = ImageItemSceneController(viewModel, coordinator)
            self.navigationController.pushViewController(scene, animated: true)
        }
    }
}

