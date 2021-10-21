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
    @inlinable
    public static func unblockAll() {
        var emptySigset = sigset_t()
        unblock(sigset: &emptySigset)
    }

    @usableFromInline
    @inline(__always)
    static func unblock(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_UNBLOCK, sigset, nil)
    }

    @inlinable
    public static func unblock(_ signal: Signal) {
        var setToUnblock = sigset_t(signal.rawValue)
        unblock(sigset: &setToUnblock)
    }

    @inlinable
    @_transparent
    public static func unblock(_ signals: Signal...) {
        unblock(signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public static func unblock<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToUnblock = signals.sigset
        unblock(sigset: &setToUnblock)
    }
}
