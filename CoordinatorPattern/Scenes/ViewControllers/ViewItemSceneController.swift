//
//  ViewItemSceneController.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 27.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewItemSceneController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private let viewModel: ViewItemViewModelType
    private let bag = DisposeBag()
    
    init(_ viewModel: ViewItemViewModelType, _ coordinator: MainCoordinator? ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title = "App"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
