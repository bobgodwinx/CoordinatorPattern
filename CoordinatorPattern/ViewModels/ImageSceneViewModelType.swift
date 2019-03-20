//
//  ImageSceneViewModelType.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 20.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ImageSceneViewModelType {
    var imageURL: Driver<URL?> { get }
}
