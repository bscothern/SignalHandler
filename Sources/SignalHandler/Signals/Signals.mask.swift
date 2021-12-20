//
//  Signals.mask.swift
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
    /// The `SignalSet` that describes signals that are currently blocked.
    @inlinable
    public var currentMask: SignalSet {
        var blockedSignals = sigset_t.emptySet()
        // According to the man page, if the `set` (2nd arg) is null then `how` (1st arg) doesn't matter.
        // It only will set the blocked signal value so you can examine the signal mask without modification.
        sigprocmask(0, nil, &blockedSignals)
        return SignalSet(blockedSignals)
    }

    /// Sets the current mask of signals that are blocked.
    ///
    /// - Important: After this is called only the values given to it will be blocked.
    ///
    /// - Parameter sigset: A pointer to the `sigset_t` containing the values to block.
    @usableFromInline
    @inline(__always)
    static func mask(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_SETMASK, sigset, nil)
    }

    /// Sets the current mask of signals that are blocked.
    ///
    /// - Important: After this is called only the values given to it will be blocked.
    ///
    /// - Parameter signal: The `Signal` to block.
    @inlinable
    public static func mask(_ signal: Signal) {
        var sigset = sigset_t.emptySet() | numericCast(signal.rawValue)
        mask(sigset: &sigset)
    }

    /// Sets the current mask of signals that are blocked.
    ///
    /// - Important: After this is called only the values given to it will be blocked.
    ///
    /// - Parameter signals: The `Signal`s to block.
    @inlinable
    public static func mask(_ signals: Signal...) {
        mask(signals)
    }

    /// Sets the current mask of signals that are blocked.
    ///
    /// - Important: After this is called only the values given to it will be blocked.
    ///
    /// - Parameter signals: The `Signal`s to block.
    @inlinable
    @_specialize(where S == [Signal])
    public static func mask<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        mask(sigset: &setToBlock)
    }
}
