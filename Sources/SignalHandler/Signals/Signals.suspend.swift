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

    /// Temporarily change the blocked signal mask of inputs to this function. Then wait for the signal to arrive; on return the previous set of masked signals is restored.
    ///
    /// In normal usage a signal is blocked using ``block(_:)-9tf1z`` or ``mask(_:)-8lag2`` calls to begin a critical section.
    /// Variables modified on the occurrence of the signal are examined to determine that there is no work to be done.
    /// Then the process pauses awaiting work by using this function with the previous mask returned by ``currentMask``.
    ///
    /// For more info see `man sigsuspend`.
    ///
    /// - Important: Usually this is called with `nil` in order to allow all signals to arrive for the duration of the call.
    ///
    /// - Parameter signal: The `Signal` if any to block until this function call returns.
    @inlinable
    public func suspend(_ signal: Signal? = nil) {
        var sigset = sigset_t.emptySet()
        if let signal = signal {
            sigset |= numericCast(signal.rawValue)
        }
        suspend(sigset: &sigset)
    }

    /// Temporarily change the blocked signal mask of inputs to this function. Then wait for the signal to arrive; on return the previous set of masked signals is restored.
    ///
    /// In normal usage a signal is blocked using ``block(_:)-9tf1z`` or ``mask(_:)-8lag2`` calls to begin a critical section.
    /// Variables modified on the occurrence of the signal are examined to determine that there is no work to be done.
    /// Then the process pauses awaiting work by using this function with the previous mask returned by ``currentMask``.
    ///
    /// For more info see `man sigsuspend`.
    ///
    /// - Important: Usually this is called with no signals in order to allow all signals to arrive for the duration of the call.
    ///
    /// - Parameter signal: The `Signal`s to block until this function call returns.
    @inlinable
    public func suspend(_ signals: Signal...) {
        suspend(signals)
    }

    /// Temporarily change the blocked signal mask of inputs to this function. Then wait for the signal to arrive; on return the previous set of masked signals is restored.
    ///
    /// In normal usage a signal is blocked using ``block(_:)-9tf1z`` or ``mask(_:)-8lag2`` calls to begin a critical section.
    /// Variables modified on the occurrence of the signal are examined to determine that there is no work to be done.
    /// Then the process pauses awaiting work by using this function with the previous mask returned by ``currentMask``.
    ///
    /// For more info see `man sigsuspend`.
    ///
    /// - Important: Usually this is called with no signals in order to allow all signals to arrive for the duration of the call.
    ///
    /// - Parameter signal: The `Signal`s to block until this function call returns.
    @inlinable
    @_specialize(where S == [Signal])
    public func suspend<S>(_ signals: S) where S: Sequence, S.Element == Signal {
        var sigset = signals.sigset
        suspend(sigset: &sigset)
    }
}
