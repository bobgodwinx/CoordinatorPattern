//
//  ImageItemSceneController.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 05.04.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImageItemSceneController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let viewModel: ImageSceneViewModelType
    private let bag = DisposeBag()
    
    
    init(_ viewModel: ImageSceneViewModelType, _ coordinator: MainCoordinator? ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title = "Detail"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
