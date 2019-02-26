//
//  ViewItemCell.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 26.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BindableCell {
    func bind(_ viewModel: ViewItemCellViewModelType)
}


class ViewItemCell: UICollectionViewCell, BindableCell {
    
    private var bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func bind(_ viewModel: ViewItemCellViewModelType) {
        viewModel
            .thumbnailURL
            .drive(imageView.rx.imageURL(errorImage: #imageLiteral(resourceName: "ImageError")))
            .disposed(by: bag)
    }
    
    private func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ImageLoading")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
