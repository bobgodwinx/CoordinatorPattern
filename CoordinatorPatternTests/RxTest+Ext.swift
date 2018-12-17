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

extension TestableObserver {
    func map<U>(_ transform: (Element) -> U) -> [Recorded<Event<U>>] {
        return events.map {recorded -> Recorded<Event<U>> in
            let transformed = recorded.value.map(transform)
            return Recorded(time: recorded.time, value: transformed)
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
    
    /// Builds a testable observable that completes immediately
    ///
    /// - Parameter time: clock time to emit on, default is 0
    /// - Returns: Testable observable that behaves similar to `Observable.empty()`
    func empty<T>(at time: Int = 0) -> TestableObservable<T> {
        return createColdObservable([Recorded.completed(time, T.self)])
    }
    
    /// Builds a testable observable that send a single value then completes.
    ///
    /// - Parameters:
    ///   - value: Value to be emitted
    ///   - time: clock time to emit on, default is 0
    /// - Returns: Testable observable that behaves similar to `Observable.just()`
    func just<T>(_ value: T, at time: Int) -> TestableObservable<T> {
        return createColdObservable([Recorded.next(time, value),
                                     Recorded.completed(time + 1)])
    }
    
    func just<T>(_ value: T, after: Int = 0) -> TestableObservable<T> {
        let time = clock + after
        return just(value, at: time)
    }
    func error<T>(_ error: Error, at time: Int) -> TestableObservable<T> {
        return createColdObservable([Recorded(time: time, value: Event<T>.error(error))])
    }
    
    func error<T>(_ error: Error, after: Int = 0) -> TestableObservable<T> {
        let time = clock + after
        return self.error(error, at: time)
    }
}
