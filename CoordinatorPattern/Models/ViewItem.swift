//
//  ViewItem.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 05.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

struct ViewItem: Decodable, Hashable {
    let thumbnail: String
    let image: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        thumbnail = (try container.decode(String.self, forKey: .uri))
            .withPrefix(Append.prefix)
            .withSuffix(Append.thumbnailSuffix)
        
        image = (try container.decode(String.self, forKey: .uri))
            .withPrefix(Append.prefix)
            .withSuffix(Append.imageSuffix)
    }
    
    private enum CodingKeys: String, CodingKey {
        case uri
    }
    
    private enum Append {
        static let prefix: String = "https://"
        static let thumbnailSuffix: String = "_2.jpg"
        static let imageSuffix: String = "_27.jpg"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.thumbnail)
        hasher.combine(self.image)
    }
}

extension ViewItem: Response {}
