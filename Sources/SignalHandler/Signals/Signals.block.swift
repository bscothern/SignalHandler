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
    @inlinable
    public var currentBlockedSignals: SignalSet {
        var blockedSignals = sigset_t()
        sigprocmask(0, nil, &blockedSignals)
        return SignalSet(blockedSignals)
    }

    @usableFromInline
    @inline(__always)
    static func block(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_BLOCK, sigset, nil)
    }

    @inlinable
    public static func block(_ signal: Signal) {
        var setToBlock = sigset_t(signal.rawValue)
        block(sigset: &setToBlock)
    }

    @inlinable
    @_transparent
    public static func block(_ signals: Signal...) {
        block(signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public static func block<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        block(sigset: &setToBlock)
    }
}
