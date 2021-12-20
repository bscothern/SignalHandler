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
    /// Restores the default signal handler action for a `Signal`.
    ///
    /// - Parameter signal: The `Signal` which should have its default action triggered when raised.
    @inlinable
    public static func restoreDefaultAction(for signal: Signal) {
        guard signal.canBeIgnored && signal.canBeCaught else {
            return
        }
        _signal(signal.rawValue, SIG_DFL)
        handlers.removeValue(forKey: signal)
    }

    /// Restores the default signal handlers action for all input `Signal`s.
    ///
    /// - Parameter signals: The `Signal`s which should have their default action triggered when raised.
    @inlinable
    public static func restoreDefaultActions(for signals: Signal...) {
        restoreDefaultActions(for: signals)
    }

    /// Restores the default signal handlers action for `Signal`s in the sequence.
    ///
    /// - Parameter signals: The `Signal`s which should have their default action triggered when raised.
    @inlinable
    @_specialize(where S == [Signal])
    public static func restoreDefaultActions<S>(for signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            restoreDefaultAction(for: signal)
        }
    }
}
