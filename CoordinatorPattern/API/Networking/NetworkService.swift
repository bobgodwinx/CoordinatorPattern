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
    
    /// Handles errors from
    /// network requests
    enum Error: Swift.Error {
        case badRequestURL
        case badHTTPStatus(code: Int)
        case requestTimedOut
        case noInternet
    }
    
    /// Injectable URLSession and baseURL
    private let session: URLSessionType
    private let baseURL: String
    
    /// Used to configure HTTPHeader
    private enum HTTPHeaderField {
        static let ContentType = "Content-type"
        static let ContentTypeJSON = "application/json"
        static let AcceptType = "Accept"
    }
    
    //Mark: init
    init(baseURLString url: String, urlSession: URLSessionType) {
        self.baseURL = url
        self.session = urlSession
    }
    
    func request(path: String, httpMethod method: HTTPMethod, parameters: NetworkParams?) -> Observable<NetworkResponse> {
        
        //silence the compiler
        return Observable.empty()
    }
}
