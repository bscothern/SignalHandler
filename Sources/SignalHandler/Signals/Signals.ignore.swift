//
//  Signals.ignore.swift
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
    /// Ignore a `Signal`.
    ///
    /// - Important: If `signal.canBeIgnored` is `false` then this just returns.
    ///
    /// - Parameter signal: The `Signal` to ignore.
    @inlinable
    public static func ignore(_ signal: Signal) {
        guard signal.canBeIgnored else {
            return
        }
        _signal(Int32(signal.rawValue), SIG_IGN)
    }

    /// Ignore all input `Signal`s.
    ///
    /// - Important: If any of the values `canBeIgnored` is `false` then it is skipped.
    ///
    /// - Parameter signal: The `Signal`s to ignore.
    @inlinable
    public static func ignore(_ signals: Signal...) {
        ignore(signals)
    }

    /// Ignore all `Signal`s in the sequence.
    ///
    /// - Important: If any of the values `canBeIgnored` is `false` then it is skipped.
    ///
    /// - Parameter signal: The `Signal`s to ignore.
    @inlinable
    @_specialize(where S == [Signal])
    public static func ignore<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal)
        }
    }
}
