//
//  NetworkService.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 22.11.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// `NetworkService` conforms to
/// `Networking` which defines
/// the contract for network communications
class NetworkService: Networking {
    func request(path: String, httpMethod method: HTTPMethod, parameters: NetworkParams?) -> Observable<NetworkResponse> {
        
        //silence the compiler
        return Observable.empty()
    }
}
