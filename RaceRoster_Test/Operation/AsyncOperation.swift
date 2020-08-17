//
//  AsyncOperation.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    public var state = State.isReady {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
}

extension AsyncOperation {
    enum State: String {
        case isReady
        case isExecuting
        case isFinished
    }
}

// MARK: - Operation Overrides
extension AsyncOperation {
    override var isReady: Bool {
        super.isReady && state == .isReady
    }

    override var isExecuting: Bool {
        state == .isExecuting
    }

    override var isFinished: Bool {
        state == .isFinished
    }

    override var isAsynchronous: Bool {
        true
    }

    override func start() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        main()
        state = .isExecuting
    }

    override func cancel() {
        super.cancel()
        state = .isFinished
    }
}
