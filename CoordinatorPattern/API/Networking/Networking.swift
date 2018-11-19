//
//  Networking.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 19.11.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: Network Response Type
typealias NetworkResponse = Data
typealias DataTaskResponseType = (HTTPURLResponse, Data)
typealias NetworkParams = String

//MARK: HTTP Request Method
enum HTTPMethod: String {
    /// This is actually
    /// the only method
    /// found on the API
    case GET = "GET"
}

//MARK: API Response Type
protocol Response {}
