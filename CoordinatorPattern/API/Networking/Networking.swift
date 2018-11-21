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

/// `ResponseArray` shadow the `Response` protocol
/// and enforce that the collection attains a static
/// dispatch.
/// e.g ResponseArray<ViewItem> should contain an
/// Array with only a `ViewItem` concrete Types
struct ResponseArray<T: Response>: Response, Collection {
    let content: [T]
    
    init(content: [T]) {
        self.content = content
    }
    var startIndex: Int { return 0 }
    var endIndex: Int { return content.count }
    
    subscript(position: Int) -> T {
        return content[position]
    }
    func index(after i: Int) -> Int {
        return i + 1
    }
}

//MARK: API Resource Type
protocol Resource {
    /// `ResponseType` is a generic placeholder
    /// to be concretized at parse time.
    associatedtype ResponseType: Response
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: NetworkParams? { get }
    
    /// @method: func parse(networkResponse response: NetworkResponse) throws -> ResponseType
    ///
    /// @param networkResponse: - a NetworkResponse type
    ///
    /// @return ResponseType: - any `Type` that conforms to `Response`
    func parse(networkResponse response: NetworkResponse) throws -> ResponseType
}

protocol Networking  {
    /// @method: request(path: String, httpMethod method: HTTPMethod, parameters: NetworkParams)
    ///
    /// @param path:  - a string type that represents the path to the endPoint
    /// @param httpMethod: - an HTTPMethod type that specifies the method for the request
    /// e.g GET
    /// @param parameters: - a `NetworkParams` type
    ///
    /// @param parameters: - an optional Array of Strings
    func request(path: String, httpMethod method: HTTPMethod,
                 parameters: NetworkParams?) -> Observable<NetworkResponse>
}

protocol URLSessionType {
    /// @method: response(for request: URLRequest) -> Observable<(HTTPURLResponse, Data)>
    ///
    /// @param request: - a URLRequest type
    ///
    /// @return DataTaskResponseType: - a `Type` of Tuple `(HTTPURLResponse, Data)`
    ///
    func response(for request: URLRequest) -> Observable<DataTaskResponseType>
}

extension URLSession: URLSessionType {
    /// `URLSession` conforming to `URLSessionType`
    func response(for request: URLRequest) -> Observable<DataTaskResponseType> {
        return rx.response(request: request)
            .map {($0.response, $0.data)}
            .observeOn(MainScheduler.instance)
    }
}
