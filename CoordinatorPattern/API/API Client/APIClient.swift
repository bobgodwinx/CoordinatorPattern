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
    //TODO: Figure out how to hide the init but still testable..
    init(networkService: Networking) {
        self.network = networkService
    }
    
    /// sharedInstance
    static let shared: APIClient = {
        let baseURL: String = "https://m.mobile.de"
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: config)
        
        return APIClient(networkService: NetworkService(baseURLString: baseURL, urlSession: session))
    }()
}
