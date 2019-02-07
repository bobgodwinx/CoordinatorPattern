//
//  ViewItemAPI.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 07.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewItemAPI {
    func fetchViewItems(with id: String) -> Observable<[ViewItem]>
}
