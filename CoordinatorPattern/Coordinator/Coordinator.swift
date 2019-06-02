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
