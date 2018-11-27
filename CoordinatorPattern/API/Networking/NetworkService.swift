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
        
        return Observable
            .deferred { [unowned self] in
                var urlStr = self.baseURL
                urlStr.append("/\(path)")
                
                if let params = parameters {
                    let encodedParams = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                    urlStr.append("/")
                    urlStr.append(encodedParams)
                }
                
                guard let url = URL(string: urlStr) else {
                    throw Error.badRequestURL
                }
                var request = URLRequest(url: url)
                
                request.httpMethod = method.rawValue
                request.addValue(HTTPHeaderField.ContentTypeJSON, forHTTPHeaderField: HTTPHeaderField.ContentType)
                request.addValue(HTTPHeaderField.ContentTypeJSON, forHTTPHeaderField: HTTPHeaderField.AcceptType)
                
                return Observable.of(request)
            }
            .catchError {
                let error = $0 as NSError
                guard error.domain == NSURLErrorDomain else { throw $0 }
                switch error.code {
                case NSURLErrorTimedOut:
                    throw Error.requestTimedOut
                case NSURLErrorNotConnectedToInternet:
                    throw Error.noInternet
                default:
                    throw error
                }
            }
            .flatMap { [unowned self] request in
                return self.session.response(for: request)
                    .map {(response: HTTPURLResponse, data: Data) -> NetworkResponse in
                        guard 200..<400 ~= response.statusCode else {
                            throw Error.badHTTPStatus(code: response.statusCode)
                        }
                        return data
                }
        }
    }
}
