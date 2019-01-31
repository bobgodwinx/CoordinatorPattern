//
//  Foundation+Ext.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 31.01.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
    
    func withSuffix(_ suffix: String) -> String {
        if self.hasSuffix(suffix) { return self }
        return "\(self)\(suffix)"
    }
}
