//
//  Signal.swift
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

/// Namespace of functions for working with signals.
public enum Signals {}

// MARK: - Default Action
extension Signals {
    @inlinable
    public static func defaultAction(for _signal: Signal) {
        guard _signal.canBeIgnored && _signal.canBeCaught else {
            return
        }
        signal(Int32(_signal.rawValue), SIG_DFL)
    }

    @inlinable
    public static func defaultAction(for signals: Signal...) {
        ignore(signals: signals)
    }

    @inlinable
    public static func defaultAction<S>(for signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal: signal)
        }
    }
}

// MARK: - Ignore
extension Signals {
    @inlinable
    public static func ignore(signal _signal: Signal) {
        guard _signal.canBeIgnored else {
            return
        }
        signal(Int32(_signal.rawValue), SIG_IGN)
    }

    @inlinable
    public static func ignore(signals: Signal...) {
        ignore(signals: signals)
    }

    @inlinable
    public static func ignore<S>(signals: S) where S: Sequence, S.Element == Signal {
        for signal in signals {
            ignore(signal: signal)
        }
    }
}

// MARK: - Block
extension Signals {
    @inlinable
    public var currentBlockedSignals: Set<Signal> {
        var blockedSignals = sigset_t()
        sigprocmask(0, nil, &blockedSignals)
        return Signal.parse(mask: blockedSignals)
    }

    @usableFromInline
    @inline(__always)
    static func block(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_BLOCK, sigset, nil)
    }

    @inlinable
    public static func block(signal: Signal) {
        var setToBlock = sigset_t(signal.rawValue)
        block(sigset: &setToBlock)
    }

    @inlinable
    @_transparent
    public static func block(signals: Signal...) {
        block(signals: signals)
    }

    @inlinable
    public static func block<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.lazy.filter(\.canBeIgnored).sigset
        block(sigset: &setToBlock)
    }
}

// MARK: - Unblock
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
    public static func unblock(signal: Signal) {
        var setToUnblock = sigset_t(signal.rawValue)
        unblock(sigset: &setToUnblock)
    }

    @inlinable
    @_transparent
    public static func unblock(signals: Signal...) {
        unblock(signals: signals)
    }

    @inlinable
    public static func unblock<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToUnblock = signals.sigset
        unblock(sigset: &setToUnblock)
    }
}

// MARK: - Set Mask
extension Signals {
    @usableFromInline
    @inline(__always)
    static func mask(sigset: UnsafeMutablePointer<sigset_t>) {
        sigprocmask(SIG_SETMASK, sigset, nil)
    }

    @inlinable
    public static func mask(signal: Signal) {
        var sigset = sigset_t(signal.rawValue)
        mask(sigset: &sigset)
    }

    @inlinable
    public static func mask(signals: Signal...) {
        mask(signals: signals)
    }

    @inlinable
    public static func mask<S>(signals: S) where S: Sequence, S.Element == Signal {
        var setToBlock = signals.lazy.filter(\.canBeIgnored).sigset
        mask(sigset: &setToBlock)
    }
}
