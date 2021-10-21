//
//  Signals.suspend.swift
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
    func suspend(sigset: UnsafeMutablePointer<sigset_t>) {
        sigsuspend(sigset)
    }

    @inlinable
    public func suspend(_ signal: Signal) {
        var sigset = sigset_t(signal.rawValue)
        suspend(sigset: &sigset)
    }

    @inlinable
    public func suspend(_ signals: Signal...) {
        suspend(signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public func suspend<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var sigset = signals.sigset
        suspend(sigset: &sigset)
    }
}
