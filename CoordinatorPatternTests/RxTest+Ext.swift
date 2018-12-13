//
//  RxTest+Ext.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 13.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest

extension Event {
    /// Sequence terminated with an error.
    /// case error(Swift.Error)
    /// on an Observable Sequence
    var isError: Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }
}

extension TestScheduler {
    
    /// Builds testable observer for s specific observable sequence,
    /// binds it's results and sets up disposal.
    ///
    /// - parameter source: Observable sequence to observe.
    /// - returns: Observer that records all events for observable sequence.
    func record<O: ObservableConvertibleType>(source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
    
    /// Builds a hot observable with a predefines events,
    /// binds it's result to a specific observer and sets up disposal.
    ///
    /// - Parameters:
    ///   - target: Observer to bind to
    ///   - events: Array of recorded events to emit over the scheduled observable
    func drive<O: ObserverType>(_ target: O, with events: [Recorded<Event<O.Element>>]) {
        let driver = self.createHotObservable(events)
        let disposable = driver.asObservable().bind(to: target)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
    }
}
