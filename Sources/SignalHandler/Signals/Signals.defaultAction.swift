//
//  Signals.defaultAction.swift
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
    public static func restoreDefaultAction(for _signal: Signal) {
        guard _signal.canBeIgnored && _signal.canBeCaught else {
            return
        }
        signal(_signal.rawValue, SIG_DFL)
        handlers.removeValue(forKey: _signal)
    }

    @inlinable
    public static func restoreDefaultActions(for signals: Signal...) {
        restoreDefaultActions(for: signals)
    }

    @inlinable
    @_specialize(where S == [Signal])
    public static func restoreDefaultActions<S>(for signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            restoreDefaultAction(for: signal)
        }
    }
}
