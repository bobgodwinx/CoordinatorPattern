//
//  ViewItemEndpoint.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 07.05.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift

struct ViewItemEndpoint: Resource {
    
    init(parameters: String?) {
        self.parameters = parameters
    }
    
    typealias Response = ResponseArray<ViewItem>
    
    var path: String { return "svc/a" }
    var method: HTTPMethod { return HTTPMethod.GET }
    var parameters: String?
    
    func parse(networkResponse response: NetworkResponse) throws -> ResponseArray<ViewItem> {
        let decoder = JSONDecoder()
        
        guard let container: ItemContainer = try? decoder.decode(ItemContainer.self, from: response) else {
            throw APIClient.Error.misformattedResponse
        }
        
        return ResponseArray(content: container.images)
    }
}

/// Conforming to `ViewItemAPI`
/// This enables us to inject
/// `APIClient` as a Type of `ViewItemAPI`
extension APIClient: ViewItemAPI {
    
    func fetchViewItems(with id: String) -> Observable<[ViewItem]> {
        let resource = ViewItemEndpoint(parameters: id)
        return request(resource).map { $0.content }
    }
}
