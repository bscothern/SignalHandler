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
    @inlinable
    public static func ignore(_ _signal: Signal) {
        guard _signal.canBeIgnored else {
            return
        }
        signal(Int32(_signal.rawValue), SIG_IGN)
    }

    @inlinable
    public static func ignore(_ signals: Signal...) {
        ignore(signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public static func ignore<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal)
        }
    }
}
