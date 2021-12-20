//
//  Signals.raise.swift
//  SignalHandler
//
//  Created by Braden Scothern on 9/17/21.
//  Copyright © 2021 Braden Scothern. All rights reserved.
//

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

extension Signals {
    /// Sends a `Signal` to the current thread.
    ///
    /// - Parameter signal: The `Signal` to raise to the current thread.
    @inlinable
    public static func raise(_ signal: Signal) {
#if canImport(Darwin)
        Darwin.raise(signal.rawValue)
#elseif canImport(Glibc)
        Glibc.raise(signal.rawValue)
#endif
    }
}
