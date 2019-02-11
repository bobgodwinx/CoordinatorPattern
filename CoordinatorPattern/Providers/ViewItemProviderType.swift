//
//  ViewItemProviderType.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 11.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewItemProviderType {
    var items: Observable<[ViewItemCellViewModelType]> {get}
    var isFetching: Observable<Bool> {get}
    var sink: AnyObserver<String> {get}
}

