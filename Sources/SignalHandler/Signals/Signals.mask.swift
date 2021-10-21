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
    @usableFromInline
    @inline(__always)
    static func mask(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_SETMASK, sigset, nil)
    }

    @inlinable
    public static func mask(_ signal: Signal) {
        var sigset = sigset_t(signal.rawValue)
        mask(sigset: &sigset)
    }

    @inlinable
    public static func mask(_ signals: Signal...) {
        mask(signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public static func mask<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.sigset
        mask(sigset: &setToBlock)
    }
}
