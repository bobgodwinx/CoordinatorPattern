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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.datasource
            .drive(collectionView.rx.items(dataSource: CollectionDatasource()))
            .disposed(by: bag)
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register([ViewItemRow.self])
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        
        return collectionView
    }()
}

extension ViewItemSceneController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// calculate the screen size / 2
        let size: CGSize = UIScreen.main.bounds.size
        let cellSize: CGFloat = (size.width / 2) - 8
        return CGSize(width: cellSize, height: (cellSize - 44))
    }
}
