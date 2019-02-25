//
//  UIImageView+Rx+Ext.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 25.05.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: UIImageView {
    func imageURL(placeholderImage: UIImage? = nil, errorImage: UIImage? = nil) -> Binder<URL?> {
        return Binder(self.base) { imageView, url in
            imageView.image = placeholderImage
            imageView.kf.setImage(with: url) { result in
                switch result {
                case .success(let value):
                    imageView.image = value.image
                case .failure(_):
                    imageView.image = errorImage
                }
            }
        }
    }
}
