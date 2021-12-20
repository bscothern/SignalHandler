//
//  Signals.unblock.swift
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
    /// Unblock all `Signal`s so they can all be delivered to the process.
    @inlinable
    public static func unblockAll() {
        var emptySigset = Signal.allCases.sigset
        unblock(sigset: &emptySigset)
    }

    @usableFromInline
    @inline(__always)
    static func unblock(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_UNBLOCK, sigset, nil)
    }

    /// Unblock a `Signal` so it will be received by the process if raised.
    ///
    /// - Parameter signal: The `Signal` to allow into the process.
    @inlinable
    public static func unblock(_ signal: Signal) {
        var setToUnblock = sigset_t.emptySet() | numericCast(signal.rawValue)
        unblock(sigset: &setToUnblock)
    }

    /// Unblock all input `Signal`s so they will be received by the process if raised.
    ///
    /// - Parameter signal: The `Signal`s to allow into the process.
    @inlinable
    @_transparent
    public static func unblock(_ signals: Signal...) {
        unblock(signals)
    }

    /// Unblock `Signal`s in the sequence so they will be received by the process if raised.
    ///
    /// - Parameter signal: The `Signal`s to allow into the process.
    @inlinable
    @_specialize(where S == [Signal])
    public static func unblock<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToUnblock = signals.sigset
        unblock(sigset: &setToUnblock)
    }
}
