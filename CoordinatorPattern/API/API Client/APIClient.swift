//
//  APIClient.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 26.01.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    /// Injected `Networking`
    fileprivate let network: Networking
    
    /// API Error
    enum Error: Swift.Error {
        case general
        case misformattedResponse
    }
    
    /// Initialization
    init(networkService: Networking) {
        self.network = networkService
    }
}
