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
    func start()
}


class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = false
    }
    
    func start() {
        ///Implement the initial viewcontroller
    }
}

