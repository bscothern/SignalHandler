//
//  Signals.block.swift
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
    @usableFromInline
    static func block(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_BLOCK, sigset, nil)
    }

    /// Block a `Signal`.
    ///
    /// - Parameter signal: The `Signal` to block.
    @inlinable
    public static func block(_ signal: Signal) {
        var setToBlock = sigset_t.emptySet() | numericCast(signal.rawValue)
        block(sigset: &setToBlock)
    }

    /// Blocks all input `Signal`s.
    ///
    /// - Parameter signals: The `Signal`s to block.
    @inlinable
    @_transparent
    public static func block(_ signals: Signal...) {
        block(signals)
    }

    /// Blocks all `Signal`s in a sequence.
    ///
    /// - Parameter signals: The `Signal`s to block.
    @inlinable
    @_specialize(where S == [Signal])
    public static func block<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        block(sigset: &setToBlock)
    }
}
